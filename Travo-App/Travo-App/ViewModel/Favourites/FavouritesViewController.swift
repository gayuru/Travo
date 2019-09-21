//
//  FavouritesCollectionViewController.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 21/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit
import Cosmos

class FavouritesViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet var bottomNav: UIView!
    @IBOutlet var favouriteButton: UIImageView!
    @IBOutlet var displayLabel: UILabel!
    
    var currentUser : User?
    var viewModel = PlacesViewModel()
    var currTitle : String = ""
    //pass value into this
    var currentCollection:collections = collections.favourites
    
    lazy var tempRecommended = viewModel.getRecommended()
    lazy var tempPopular = viewModel.getPopularity()
    
    enum collections{
        case favourites
        case popular
        case recommended
    }

    let cellScaling:CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        bottomNav.layer.cornerRadius = 10
        bottomNav.layer.masksToBounds = true
    }
    
    @IBAction func homeBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
}

extension FavouritesViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(validateUser()){
            if (currentUser?.getFavourites().count)! <= 0{
                displayLabel.text = "No Favourites"
                favouriteButton.image = UIImage(named: "nav_heart_enabled")
                return 0
            }else{
                displayLabel.isHidden = true
                return (currentUser?.getFavourites().count)!
            }
        }
       displayLabel.isHidden = true
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCell", for: indexPath) 
        let title = cell.viewWithTag((1000)) as! UILabel
        let location = cell.viewWithTag((1001)) as! UILabel
        let openTime = cell.viewWithTag((1002)) as! UILabel
        let imageView = cell.viewWithTag((1003)) as! UIImageView
        let placeRating = cell.viewWithTag((1004)) as! CosmosView
        placeRating.settings.updateOnTouch = false
        placeRating.settings.fillMode = .precise
        title.numberOfLines = 0
        title.lineBreakMode = NSLineBreakMode.byWordWrapping
        title.sizeToFit()
        //TODO:- Add null check
        if(currentCollection == collections.favourites && (currentUser?.getFavourites().count)! <= 0){
            return cell
        }
        
        switch currentCollection {
        
        case collections.popular:
            heading.text = "Popular Places"
            title.text = tempPopular[indexPath.row].name
            imageView.image = UIImage(named: tempPopular[indexPath.row].imageURL)
            location.text = tempPopular[indexPath.row].location
            openTime.text = tempPopular[indexPath.row].openTime
            placeRating.rating = tempPopular[indexPath.row].starRating
            placeRating.text = String(tempPopular[indexPath.row].starRating)
        case collections.recommended:
            heading.text = "Recommended Places"
            title.text = tempRecommended[indexPath.row].name
            imageView.image = UIImage(named: tempRecommended[indexPath.row].imageURL)
            location.text = tempRecommended[indexPath.row].location
            openTime.text = tempRecommended[indexPath.row].openTime
            placeRating.rating = tempRecommended[indexPath.row].starRating
            placeRating.text = String(tempRecommended[indexPath.row].starRating)
        default:
            heading.text = "Favourites"
            if((currentUser?.getFavourites().count)!>0){
                if let favourites = currentUser?.getFavourites()[indexPath.row]{
                    title.text = favourites.name
                    imageView.image = UIImage(named: favourites.imageURL)
                    location.text = favourites.location
                    openTime.text = favourites.openTime
                    placeRating.rating = favourites.starRating
                    placeRating.text = String(favourites.starRating)
                    favouriteButton.image = UIImage(named: "nav_heart_enabled")
                }
            }else{
                title.text = viewModel.getTitleFor(index: indexPath.row)
                imageView.image = viewModel.getImageURLFor(index: indexPath.row)
                location.text = viewModel.getLocationFor(index: indexPath.row)
                openTime.text = viewModel.getOpenTimeFor(index: indexPath.row)
                placeRating.rating = viewModel.getStarRating(index: indexPath.row)
                placeRating.text = String(viewModel.getStarRating(index: indexPath.row))
            }
         
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentCollection == collections.popular{
            currTitle = tempPopular[indexPath.row].name
            performSegue(withIdentifier: "goTo", sender: self)
        }
//        if collectionView == {
//            print(temp)
////            currTitle = self.temp
//        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func validateUser() -> Bool{
        if currentUser != nil{
            return true
        }
        return false
    }
}

