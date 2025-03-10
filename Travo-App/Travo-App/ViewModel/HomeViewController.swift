//
//  HomeViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 4/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation

class HomeViewController: UIViewController,Refresh,CLLocationManagerDelegate{
    
    //SAMPLE LOGIN DETAILS
    // Email : email1
    // Password : password1
    
    @IBOutlet var bottomNav: UIView!
    @IBOutlet var popularPlaces: UICollectionView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var recommendedCollection: UICollectionView!
    @IBOutlet weak var profileImage: UIButton!
    
    var loggedInUser:UserCoreData?
    var usersVM:UsersViewModel!
    let locationManager = CLLocationManager()
    var viewModel = PlacesViewModel()
    var categoryViewModel = CategoryViewModel()
    var selectedCategoryIndex = 0
    var currentCategory:String = "general"
    var previousTag:Int = 0
    var currTitle:String = ""
    var viewCount = 0
    var categoryId:String = ""
    var tempRecommended : [Place]!
    var tempPopular : [Place]!
    var tempCategory : [Category]!
    let CAROUSEL_MAX:Int = 5
    let RECOMMENDED_MAX:Int = 4
    let CATEGORIES_MAX:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get users location
        let image = loggedInUser?.userImage
        profileImage.setImage(UIImage(data: image! as Data), for: .normal)
        viewModel.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        SVProgressHUD.show()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 20.0
        self.view.isUserInteractionEnabled = false
        viewModel.delegate = self
        tempPopular = viewModel.getPopularity(category: self.currentCategory)
        tempRecommended = viewModel.getRecommended(category: self.currentCategory)
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
        popularPlaces.reloadData()
        recommendedCollection.reloadData()
        tempPopular = viewModel.getPopularity(category: self.currentCategory)
        tempRecommended = viewModel.getRecommended(category: self.currentCategory)
        tempCategory = categoryViewModel.getCategories()
        self.view.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()
    }
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            viewModel.setLocation(lat: latitude, lng: longitude)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
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
            return RECOMMENDED_MAX
        }
        return 0
    }
    
    //MARK:-- Setting up all collection views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularPlaces {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PlacesCollectionViewCell
            if (indexPath.row < tempPopular.count) {
                cell.placeLabel.text = tempPopular[indexPath.row].name
                cell.layer.cornerRadius = 10
                cell.rating.text = String(tempPopular[indexPath.row].starRating)
                cell.backgroundImage.image = viewModel.getImageURLFor(url: tempPopular[indexPath.row].imageURL)
                cell.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
                cell.timeLabel.text = tempPopular[indexPath.row].openTime
                cell.ratingView.layer.cornerRadius = 10
                cell.ratingView.layer.masksToBounds = true
                cell.timeLabel.textColor = UIColor.white
                cell.placeLabel.textColor = UIColor.white
            }
            return cell
        }else if collectionView == categoryCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            tempCategory = categoryViewModel.getCategories()
            cell.category.tag = indexPath.row
            if indexPath.row == selectedCategoryIndex {
                let tempCatVM = categoryViewModel.getCategoryEnabledImage(name: tempCategory[indexPath.row].getName())
                cell.category.image = UIImage(named: tempCatVM!)
            }else{
                cell.category.image = UIImage(named: tempCategory[indexPath.row].getImage())
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedCollectionViewCell
            tempRecommended = viewModel.getRecommended(category: currentCategory)
            if (indexPath.row < tempRecommended.count) {
                cell.locationLabel.text = tempRecommended[indexPath.row].name
                cell.placeImage.image = viewModel.getImageURLFor(url: tempRecommended[indexPath.row].imageURL)
                cell.cityLabel.text = tempRecommended[indexPath.row].location
                cell.timeLabel.text = tempRecommended[indexPath.row].openTime
                cell.placeRating.text = String(tempRecommended[indexPath.row].starRating)
                cell.placeRating.rating = tempRecommended[indexPath.row].starRating
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
            let newCell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
            let tempCatVM = categoryViewModel.getCategoryEnabledImage(name: tempCategory[indexPath.row].getName())
            newCell.category.image = UIImage(named: tempCatVM!)
            
            if let oldCell = collectionView.cellForItem(at: IndexPath.init(row: selectedCategoryIndex, section: 0)) as! CategoryCollectionViewCell? {
                oldCell.category.image = UIImage(named: tempCategory[selectedCategoryIndex].getImage())
            }
            selectedCategoryIndex = indexPath.row
            currentCategory = tempCategory[selectedCategoryIndex].getName()
            //        "general","art", "bar", "beach", "cafe", "coffee", "hike", "library", "monument", "park"
            switch currentCategory{
            case "art":
                categoryId = "4d4b7104d754a06370d81259"
            case "bar":
                categoryId = "4bf58dd8d48988d116941735"
            case "beach":
                categoryId = "4bf58dd8d48988d1e2941735"
            case "cafe":
                categoryId = "4bf58dd8d48988d16d941735"
            case "coffee":
                categoryId = "4bf58dd8d48988d1e0931735"
            case "hike":
                categoryId = "4eb1d4d54b900d56c88a45fc"
            case "library":
                categoryId = "4bf58dd8d48988d12f941735"
            case "monument":
                categoryId = "4bf58dd8d48988d12d941735"
            case "park":
                categoryId = "4bf58dd8d48988d182941735"
            default:
                categoryId = "4bf58dd8d48988d1f6931735"
                break
            }
            self.categoryCollection.reloadData()
        }
    }
}

extension HomeViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewPlace"){
            let secondController = segue.destination as! PlaceViewController
            secondController.indexPass = currTitle
            secondController.viewModel = self.viewModel
            secondController.currentUser = self.loggedInUser
        }else if(segue.identifier == "recommendedSeeAll"){
            let generalController = segue.destination as! FavouritesViewController
            generalController.currentUser = self.loggedInUser
            generalController.viewModel = self.viewModel
            generalController.currentCollection = FavouritesViewController.collections.recommended
        }else if(segue.identifier ==  "popularSeeAll"){
            let generalController = segue.destination as! FavouritesViewController
            generalController.currentUser = self.loggedInUser
            generalController.viewModel = self.viewModel
            generalController.currentCollection = FavouritesViewController.collections.popular
        }else if(segue.identifier == "favourites"){
            let favouritesController = segue.destination as! FavouritesViewController
            favouritesController.currentCollection = FavouritesViewController.collections.favourites
            favouritesController.viewModel = self.viewModel
            favouritesController.currentUser = loggedInUser
        }else if(segue.identifier == "goToProfile"){
            let profileController = segue.destination as! ProfileViewController
            profileController.currentUser = loggedInUser
        }else if(segue.identifier == "goToLucky"){
            let luckyController = segue.destination as! FeelingLuckyViewController
            luckyController.viewModel = self.viewModel
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
