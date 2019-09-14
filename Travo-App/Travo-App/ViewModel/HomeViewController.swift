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
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 2 * self.view.frame.height)
        popularPlaces.backgroundColor = UIColor(white: 1, alpha: 0.2)
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
    }
    
    
    

}
