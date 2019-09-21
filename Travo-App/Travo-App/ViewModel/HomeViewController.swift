//
//  HomeViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 4/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet var bottomNav: UIView!
    @IBOutlet var popularPlaces: UICollectionView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var recommendedCollection: UICollectionView!
    var loggedInUser:User?
    
    var viewModel = PlacesViewModel()
    var categoryViewModel = CategoryViewModel()
    
    var currTitle:String = ""
    
    let CAROUSEL_MAX:Int = 5
    let CATEGORIES_MAX:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bottomNav.layer.cornerRadius = 10.0
        bottomNav.layer.masksToBounds = true
        popularPlaces.backgroundColor = UIColor(white: 1, alpha: 0.2)
        recommendedCollection.backgroundColor = UIColor(white: 1, alpha: 0.2)
        categoryCollection.backgroundColor = UIColor.init(red: 243, green: 245, blue: 247)
        popularPlaces.delegate = self
        popularPlaces.dataSource = self
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        recommendedCollection.dataSource = self
        recommendedCollection.delegate = self
        
//        if traitCollection.forceTouchCapability == UIForceTouchCapability.available{
//            registerForPreviewing(with: self, sourceView: view)
//        }else{
//            print("Device doesn't support force touch")
//        }
    }
    

    @IBAction func unwindToHome(segue:UIStoryboardSegue){}
    
    lazy var tempRecommended = viewModel.getRecommended()
    lazy var tempPopular = viewModel.getPopularity()
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
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.5
            cell.backgroundImage.image = UIImage(named:tempPopular[indexPath.row].imageURL)
            cell.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            cell.label1.text = tempPopular[indexPath.row].name
            cell.label1.textColor = UIColor.white
            cell.label1.numberOfLines = 3
            cell.label1.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.label1.sizeToFit()
            return cell
        }else if collectionView == categoryCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            var tempCategory = categoryViewModel.getCategories()
            if indexPath.row == 0 {
                let tempCatVM = categoryViewModel.getCategoryEnabledImage(name: tempCategory[indexPath.row].getName())
                cell.category.setImage(UIImage(named: tempCatVM!), for: .normal)
            }else{
                cell.category.setImage(UIImage(named: tempCategory[indexPath.row].getImage()), for: .normal)
            }
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
            cell.locationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.locationLabel.sizeToFit()
//            cell.likeBtn.addTarget(self, action: #selector(likeButtonTapped(cell: cell)), for: UIControl.Event.touchUpInside)
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.addTarget(self, action: #selector(likeButtonTapped(sender:)), for: UIControl.Event.touchUpInside)
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewPlace"){
            let secondController = segue.destination as! PlaceViewController
            secondController.indexPass = currTitle
        }else if(segue.identifier == "recommendedSeeAll"){
            let generalController = segue.destination as! FavouritesViewController
            generalController.currentCollection = FavouritesViewController.collections.recommended
        }else if(segue.identifier ==  "popularSeeAll"){
            let generalController = segue.destination as! FavouritesViewController
            generalController.currentCollection = FavouritesViewController.collections.popular
        }else if(segue.identifier == "favourites"){
            let favouritesController = segue.destination as! FavouritesViewController
            favouritesController.currentUser = loggedInUser
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
            loggedInUser?.removeFavourites(place: tempRecommended[sender.tag])
        }
    }
}


//MARK:- Force Touch Capability
//extension HomeViewController:UIViewControllerPreviewingDelegate {
////    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
////        if let indexPath = popularPlaces.indexPathForItem(at: location){
////            let cell = popularPlaces.cellForItem(at: indexPath) as! PlacesCollectionViewCell
////            let viewsTo3DTouch = [cell.backgroundImage]
////            for (index,view) in viewsTo3DTouch.enumerated() where touchedView(view, location: location){
////
////            }
////        }
//
////        let previewView = storyboard?.instantiateViewController(withIdentifier: "HomeView")
////        return previewView
//    }
//
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
//        let finalView = storyboard?.instantiateViewController(withIdentifier: "PlaceView")
//        show(finalView! , sender: self)
//    }
//}

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
