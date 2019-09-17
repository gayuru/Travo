//
//  FavouritesCollectionViewController.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 21/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    var favourites = Favourites.fetchFavourites()
    let cellScaling:CGFloat = 1.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * 0.25)
        
        let insetX = (view.bounds.width - cellWidth)
        let insetY = (view.bounds.height - cellHeight)
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView?.dataSource = self as? UICollectionViewDataSource
        collectionView?.delegate = self as? UICollectionViewDelegate
        
      
    }
}

extension FavouritesViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCell", for: indexPath) as! CardCollectionViewCell
        
        cell.favourites = favourites[indexPath.item]
        return cell
    }
}

