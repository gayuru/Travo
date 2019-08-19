//
//  ViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 14/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate {

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
        popularViewsCollections.layer.cornerRadius = 10
        popularViewsCollections.delegate = self
        loadMultipleViews()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = popularViewsCollections.dequeueReusableCell(withReuseIdentifier: "popularViewCell", for: indexPath)
        cell.backgroundColor = UIColor.green
    }
    
    private func loadMultipleViews(){
//        popularViewsCollections.dequeueReusableCell(withReuseIdentifier: "popularViewCell", for: IndexPath)
        for _ in 0...4 {
            popularViewsCollections.frame.origin.x = popularViewsCollections.frame.origin.x + 20
        }
    }
    
    
    @IBAction func profileBtnPressed(_ sender: UIButton) {
        print("Image Pressed")
    }
    

}

