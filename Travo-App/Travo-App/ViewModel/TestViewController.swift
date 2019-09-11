//
//  TestViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 4/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var placesButton: UIButton!
    @IBOutlet var sunsetButton: UIButton!
    @IBOutlet var hillButton: UIButton!
    @IBOutlet var cyclingButton: UIButton!
    @IBOutlet var bottomNav: UIView!
    @IBOutlet var popularPlaces: UICollectionView!
    @IBOutlet var recommendedPlaces: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        placesButton.imageView?.contentMode = .scaleAspectFit
        sunsetButton.imageView?.contentMode = .scaleAspectFit
        hillButton.imageView?.contentMode = .scaleAspectFit
        cyclingButton.imageView?.contentMode = .scaleAspectFit
        bottomNav.layer.cornerRadius = 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularPlaces.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundImage.image = UIImage(named: "eiffel-tower")
        cell.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFit
        cell.label1.text = "Paris"
        cell.label1.textColor = UIColor.white
        cell.label1.numberOfLines = 0
        cell.label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.label1.sizeToFit()
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
