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
    @IBOutlet var recommendedPlaces: UICollectionView!
    
    var loggedInUser:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        popularPlaces.delegate = self
        popularPlaces.dataSource = self
        placesButton.imageView?.contentMode = .scaleAspectFit
        sunsetButton.imageView?.contentMode = .scaleAspectFit
        hillButton.imageView?.contentMode = .scaleAspectFit
        cyclingButton.imageView?.contentMode = .scaleAspectFit
        bottomNav.layer.cornerRadius = 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularPlaces.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlacesCollectionViewCell
        cell.backgroundImage.image = UIImage(named: "federation-square")
        cell.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFit
        cell.label1.text = "Federation Square"
        cell.label1.textColor = UIColor.white
        cell.label1.numberOfLines = 0
        cell.label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.label1.sizeToFit()
        return cell
    }
    

}
