//
//  ViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 14/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    let items = ["0","1","2","3","4","5","6","7","8","9","10"]
    @IBOutlet var label1: UILabel!
    @IBOutlet var popularViewsCollections: UICollectionView!
    @IBOutlet var profileImageView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = UIColor.gray
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.borderWidth = 1.0
//        popularViewsCollections.layer.cornerRadius = 10
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 10
        cell.backgroundImage.image = UIImage(named: "fed")
        cell.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFit
        cell.label1.textColor = UIColor.white
        cell.label1.numberOfLines = 0
        cell.label1.text = "Federation Square"
        cell.label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.label1.sizeToFit()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

    
    @IBAction func profileBtnPressed(_ sender: UIButton) {
        print("Image Pressed")
    }
    

}


/*    private func loadMultipleViews(){
 //        popularViewsCollections.dequeueReusableCell(withReuseIdentifier: "popularViewCell", for: IndexPath)
 
 for _ in 0...4 {
 popularViewsCollections.frame.origin.x = popularViewsCollections.frame.origin.x + 20
 }
 }
*/
