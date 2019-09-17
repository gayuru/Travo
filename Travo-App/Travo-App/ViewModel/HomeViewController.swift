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
//    private var recommendButton : UIButton!
    var loggedInUser:User?
    
    var viewModel = PlacesViewModel()
    
    let CAROUSEL_MAX:Int = 5
    let CATEGORIES_MAX:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 2 * self.view.frame.height) 
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
    
    
//    @objc func likeBtnClicked(sender: UIButton){
//        recommendButton.imageView?.image = UIImage(named: "like")
//    }
}

extension HomeViewController{
    
    //MARK:-- Setting up all collection views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tempRecommended = viewModel.getRecommended()
        let tempPopular = viewModel.getPopularity()
        
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
            cell.category.setImage(UIImage(named: "category_general_enabled"), for: .normal)
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
//            recommendButton = cell.likeBtn
//            cell.likeBtn.addTarget(self, action: #selector(likeBtnClicked(sender:)), for: .touchUpInside)
            return cell
        }
      
        
    }
}
