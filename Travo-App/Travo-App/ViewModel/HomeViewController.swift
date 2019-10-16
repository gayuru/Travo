//
//  HomeViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 4/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController,Refresh{
    
    //SAMPLE LOGIN DETAILS
    // Email : email1
    // Password : password1
    
    @IBOutlet var bottomNav: UIView!
    @IBOutlet var popularPlaces: UICollectionView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var recommendedCollection: UICollectionView!
    var loggedInUser:User?
    
    var viewModel = PlacesViewModel()

    var categoryViewModel = CategoryViewModel()
    var currentCategory:String = "general"
    var currTitle:String = ""
    var tempRecommended : [Place]!
    var tempPopular : [Place]!
    var tempCategory : [Category]!
    let CAROUSEL_MAX:Int = 5
    let CATEGORIES_MAX:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        viewModel.delegate = self
        popularPlaces.dataSource = self
        recommendedCollection.dataSource = self
        bottomNav.layer.cornerRadius = 10.0
        bottomNav.layer.masksToBounds = true
        popularPlaces.backgroundColor = UIColor(white: 1, alpha: 0.2)
        recommendedCollection.backgroundColor = UIColor(white: 1, alpha: 0.2)
        categoryCollection.backgroundColor =  UIColor(white: 1, alpha: 0.0)
        popularPlaces.delegate = self
        popularPlaces.dataSource = self
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        recommendedCollection.dataSource = self
        recommendedCollection.delegate = self
    }
    
    func updateUI() {
        print("this gets called")
        popularPlaces.reloadData()
        recommendedCollection.reloadData()
        tempPopular = viewModel.getPopularity(category: self.currentCategory)
        tempRecommended = viewModel.getRecommended(category: self.currentCategory)
        tempCategory = categoryViewModel.getCategories()
        SVProgressHUD.dismiss()
    }
    
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue){}
   
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
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
    
    //MARK:-- Setting up all collection views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularPlaces {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PlacesCollectionViewCell
            tempPopular = viewModel.getPopularity(category: currentCategory)
            if (indexPath.row < tempPopular.count) {
                cell.label1.text = tempPopular[indexPath.row].name
                cell.layer.cornerRadius = 10
                cell.rating.text = String(tempPopular[indexPath.row].starRating)
                cell.backgroundImage.image = viewModel.getImageURLFor(url: tempPopular[indexPath.row].imageURL)
                cell.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
                cell.ratingView.layer.cornerRadius = 10
                cell.ratingView.layer.masksToBounds = true
                cell.label1.textColor = UIColor.white
                cell.label1.numberOfLines = 3
                cell.label1.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.label1.sizeToFit()
            }
            return cell
        }else if collectionView == categoryCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            tempCategory = categoryViewModel.getCategories()
            cell.category.tag = indexPath.row
            cell.category.addTarget(self, action: #selector(categoryButtonClicked(sender:)), for: .touchUpInside)
            if indexPath.row == 0 {
                let tempCatVM = categoryViewModel.getCategoryEnabledImage(name: tempCategory[indexPath.row].getName())
                cell.category.setImage(UIImage(named: tempCatVM!), for: .normal)
            }else{
                cell.category.setImage(UIImage(named: tempCategory[indexPath.row].getImage()), for: .normal)
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedCollectionViewCell
            tempRecommended = viewModel.getRecommended(category: currentCategory)
            if (indexPath.row < tempRecommended.count) {
                cell.locationLabel.text = tempRecommended[indexPath.row].name
                cell.placeImage.image = viewModel.getImageURLFor(url: tempRecommended[indexPath.row].imageURL)
//                cell.placeImage.image = viewModel.getImageURLFor(index: indexPath.row)
                cell.cityLabel.text = tempRecommended[indexPath.row].location
                cell.timeLabel.text = tempRecommended[indexPath.row].openTime
                cell.placeRating.text = String(tempRecommended[indexPath.row].starRating)
                cell.placeRating.rating = tempRecommended[indexPath.row].starRating
//                cell.locationLabel.text = viewModel.getTitleFor(index: indexPath.row)
//                cell.placeImage.image = viewModel.getImageURLFor(index: indexPath.row)
//                cell.cityLabel.text = viewModel.getLocationFor(index: indexPath.row)
//                cell.timeLabel.text = viewModel.getOpenTimeFor(index: indexPath.row)
//                cell.placeRating.rating = viewModel.getStarRating(index: indexPath.row)
//                cell.placeRating.text = String(viewModel.getStarRating(index: indexPath.row))
                cell.placeRating.settings.updateOnTouch = false
                cell.placeRating.settings.fillMode = .precise
                cell.likeBtn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
                cell.locationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.locationLabel.sizeToFit()
                cell.likeBtn.tag = indexPath.row
                cell.likeBtn.setImage(UIImage(named: "heart"), for: .normal)
                if((loggedInUser?.getFavourites().count)!>=0){
                    loggedInUser?.getFavourites().forEach({ (place) in
                        if(place.name == cell.locationLabel.text){
                            cell.likeBtn.setImage(UIImage(named: "like"), for: .normal)
                        }
                    })
                }
                cell.likeBtn.addTarget(self, action: #selector(likeButtonTapped(sender:)), for: UIControl.Event.touchUpInside)
            }
            return cell
        }
    }
    
    //MARK:- getSelectedItem from CollectionViewCell for display
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recommendedCollection{
            currTitle = tempRecommended[indexPath.row].name
            performSegue(withIdentifier: "viewPlace", sender: self)
        }else if collectionView == popularPlaces {
            currTitle = tempPopular[indexPath.row].name
            performSegue(withIdentifier: "viewPlace", sender: self)
        }else if collectionView == categoryCollection{
            
//            collectionView.
        }
    }
}

extension HomeViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewPlace"){
            let secondController = segue.destination as! PlaceViewController
            secondController.indexPass = currTitle
            secondController.currentUser = self.loggedInUser
        }else if(segue.identifier == "recommendedSeeAll"){
            let generalController = segue.destination as! FavouritesViewController
            generalController.currentUser = self.loggedInUser
            generalController.currentCollection = FavouritesViewController.collections.recommended
        }else if(segue.identifier ==  "popularSeeAll"){
            let generalController = segue.destination as! FavouritesViewController
            generalController.currentUser = self.loggedInUser
            generalController.currentCollection = FavouritesViewController.collections.popular
        }else if(segue.identifier == "favourites"){
            let favouritesController = segue.destination as! FavouritesViewController
            favouritesController.currentCollection = FavouritesViewController.collections.favourites
            favouritesController.currentUser = loggedInUser
        }else if(segue.identifier == "goToProfile"){
            let profileController = segue.destination as! ProfileViewController
            profileController.currentUser = loggedInUser
        }else if(segue.identifier == "goToLucky"){
            let luckyController = segue.destination as! FeelingLuckyViewController
            luckyController.currentUser = loggedInUser
        }
    }
    
    @IBAction func recommendedSeeAll(_ sender: Any) {
        performSegue(withIdentifier: "recommendedSeeAll", sender: self)
    }
    
    @IBAction func popularSeeAll(_ sender: Any) {
        performSegue(withIdentifier: "popularSeeAll", sender: self)
    }
    
    @objc func likeButtonTapped(sender:UIButton){
        if sender.currentImage == UIImage(named: "heart") {
            if ((loggedInUser?.addToFavourites(place: tempRecommended[sender.tag]))!){
                sender.setImage(UIImage(named:"like"), for: .normal)
            }
        }else{
            sender.setImage(UIImage(named:"heart"), for: .normal)
            _ = loggedInUser?.removeFavourites(place: tempRecommended[sender.tag])
        }
    }
    
    @objc func categoryButtonClicked(sender:UIButton){
        currentCategory = tempCategory[sender.tag].getName()
        sender.setImage(UIImage(named: tempCategory[sender.tag].getEnabledImage()), for: .normal)
//        self.tempRecommended = viewModel.getRecommended(category: self.currentCategory)
//        self.tempPopular = viewModel.getPopularity(category: self.currentCategory)
//        self.recommendedCollection.reloadData()
//        self.popularPlaces.reloadData()
    }
}


//MARK:- UIColor Extensions for HexCode
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
