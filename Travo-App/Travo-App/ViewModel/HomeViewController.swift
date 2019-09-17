//
//  HomeViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 4/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let items = ["0","1","2","3","4","5","6","7","8","9","10"]
    @IBOutlet var placesButton: UIButton!
    @IBOutlet var sunsetButton: UIButton!
    @IBOutlet var hillButton: UIButton!
    @IBOutlet var cyclingButton: UIButton!
    @IBOutlet var bottomNav: UIView!
    @IBOutlet var popularPlaces: UICollectionView!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var recommendedCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 2 * self.view.frame.height) 
        popularPlaces.backgroundColor = UIColor(white: 1, alpha: 0.2)
        recommendedCollection.backgroundColor = UIColor(white: 1, alpha: 0.2)
        popularPlaces.delegate = self
        popularPlaces.dataSource = self
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        recommendedCollection.dataSource = self
        recommendedCollection.delegate = self
        bottomNav.layer.cornerRadius = 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularPlaces{
            return items.count
        }else if(collectionView == self.categoryCollection){
            return 6
        }else if(collectionView == self.recommendedCollection){
            return 4
        }
        return 0
    }

        //        let cell1 = recommendedPlacesCollection.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath)
        //        collectionView.register(PlacesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        //        if collectionView == self.popularPlaces{
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlacesCollectionViewCell
        ////            let cell = popularPlaces.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlacesCollectionViewCell
        //            cell.layer.cornerRadius = 10
        //            cell.layer.borderColor = UIColor.black.cgColor
        //            cell.layer.borderWidth = 0.5
        ////            cell.backgroundImage.image = UIImage(named: "royal_botanical_gardens")
        ////            cell.backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        //            cell.label1.text = "Federation Square"
        //            cell.label1.textColor = UIColor.white
        //            cell.label1.numberOfLines = 2
        //            cell.label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        //            cell.label1.sizeToFit()
        //            return cell
        //        }
        //        else if collectionView == self.placesCollectionView{
        //            let cell = placesCollectionView.dequeueReusableCell(withReuseIdentifier: "placesCell", for: indexPath)
        //            cell.backgroundColor = UIColor.gray
        //            return cell
        //        }
        //        else if collectionView == self.recommendedPlacesCollection{
        //            let cell = recommendedPlacesCollection.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedCollectionViewCell
        //            cell.locationLabel.text = "Fed Square"
        //            cell.locationLabel.textColor = UIColor.white
        //            cell.backgroundColor = UIColor.blue
        //            return cell
        //        }
        //        return cell1

}

extension HomeViewController{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularPlaces {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PlacesCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.5
            cell.backgroundImage.image = UIImage(named: "federation-square")
            cell.backgroundImage.contentMode = UIView.ContentMode.scaleToFill
            cell.label1.text = "Federation Square"
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
            cell.locationLabel.text = "Federation Square"
            cell.placeImage.image = UIImage(named: "federation-square")
            cell.cityLabel.text = "Melbourne"
            cell.timeLabel.text = "7AM - 5PM"
            return cell
        }
        
    }
}
