//
//  HomeViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 4/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var bottomNav: UIView!
    @IBOutlet var popularPlaces: UICollectionView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var recommendedCollection: UICollectionView!
    var loggedInUser:User?
    
    var viewModel = PlacesViewModel()
    var categoryViewModel = CategoryViewModel()
    
    let CAROUSEL_MAX:Int = 5
    let CATEGORIES_MAX:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        popularPlaces.backgroundColor = UIColor(white: 1, alpha: 0.2)
        recommendedCollection.backgroundColor = UIColor(white: 1, alpha: 0.2)
        categoryCollection.backgroundColor = UIColor(white: 1, alpha: 0.2)
        popularPlaces.delegate = self
        popularPlaces.dataSource = self
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        recommendedCollection.dataSource = self
        recommendedCollection.delegate = self
        bottomNav.layer.cornerRadius = 10
    }
    
    //MARK:- Collection View Size
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularPlaces{
            return CAROUSEL_MAX
        }else if(collectionView == self.categoryCollection){
            return CATEGORIES_MAX
        }else if(collectionView == self.recommendedCollection){
            return CAROUSEL_MAX
        }
        return 0
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue){}
    
    
    lazy var tempRecommended = viewModel.getRecommended()
    lazy var tempPopular = viewModel.getPopularity()
}

extension HomeViewController{
    
    //MARK:-- Setting up all collection views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == popularPlaces {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PlacesCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.5
            cell.backgroundImage.image = UIImage(named:tempPopular[indexPath.row].imageURL)
            cell.backgroundImage.contentMode = UIView.ContentMode.scaleToFill
            cell.label1.text = tempPopular[indexPath.row].name
            cell.label1.textColor = UIColor.white
            cell.label1.numberOfLines = 2
            cell.label1.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.label1.sizeToFit()
            return cell
        }else if collectionView == categoryCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            var tempCategory = categoryViewModel.getCategories()
            cell.category.setImage(UIImage(named: tempCategory[indexPath.row].getImage()), for: .normal)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedCollectionViewCell
            
            cell.locationLabel.text = tempRecommended[indexPath.row].name
            cell.placeImage.image = UIImage(named: tempRecommended[indexPath.row].imageURL)
            cell.cityLabel.text = tempRecommended[indexPath.row].location
            cell.timeLabel.text = tempRecommended[indexPath.row].openTime
            cell.placeRating.settings.updateOnTouch = false
            cell.placeRating.settings.fillMode = .precise
            cell.placeRating.rating = tempRecommended[indexPath.row].starRating
            cell.placeRating.text = String(tempRecommended[indexPath.row].starRating)
            cell.likeBtn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == recommendedCollection{
            print(tempRecommended[indexPath.row])
        }
    }
    
    
}
