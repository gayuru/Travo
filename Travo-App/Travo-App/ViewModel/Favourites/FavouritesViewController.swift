//
//  FavouritesCollectionViewController.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 21/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit
import Cosmos

class FavouritesViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var favourites = Favourites.fetchFavourites()
    
    var viewModel = PlacesViewModel()

    
    let cellScaling:CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCell", for: indexPath) 
        
        let title = cell.viewWithTag((1000)) as! UILabel
        let location = cell.viewWithTag((1001)) as! UILabel
        let openTime = cell.viewWithTag((1002)) as! UILabel
        let imageView = cell.viewWithTag((1003)) as! UIImageView
        let starRating = cell.viewWithTag((1004)) as! CosmosView
        
        title.text = viewModel.getTitleFor(index: indexPath.row)
        location.text = viewModel.getLocationFor(index: indexPath.row)
        openTime.text = viewModel.getOpenTimeFor(index: indexPath.row)
        imageView.image = viewModel.getImageURLFor(index: indexPath.row)
        starRating.rating = viewModel.getStarRating(index: indexPath.row)
        starRating.text = String(viewModel.getStarRating(index: indexPath.row))
        
        return cell
    }
}

