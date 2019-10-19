//
//  PlaceViewController.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 15/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Cosmos

class PlaceViewController: UIViewController {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var placeOpenHours: UILabel!
    @IBOutlet weak var placeRating: CosmosView!
    @IBOutlet weak var placeWeather: UIImageView!
    @IBOutlet var placeFavourite: UIButton!
    
    var favourites : [Place]!
    var currentUser : UserCoreData!
    var indexPass = String()
    var index:Int = 0
    var currentPlace : Place!
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backHome", sender: self)
    }
    
    var viewModel:PlacesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (viewModel.placeExistsByName(name: indexPass)) {
            index = viewModel.getIndex(title: indexPass)
        }
        if let user = currentUser{
            if user.getFavourites().count <= 0{
                placeFavourite.setImage(UIImage(named: "heart"), for: .normal)
            }else{
                favourites = user.getFavourites()
                getFavourite(name: viewModel.getTitleFor(index: index))
            }
        }
        
        //testAPI()
        
        placeImage.contentMode = .scaleAspectFill
        placeTitle.text = viewModel.getTitleFor(index: index)
        placeDescription.text = viewModel.getDescFor(index: index)
        placeOpenHours.text = viewModel.getOpenTimeFor(index: index)
        placeImage.image = viewModel.getImageURLFor(index: index)
        placeRating.settings.updateOnTouch = false
        placeRating.settings.fillMode = .precise
        placeRating.rating = viewModel.getStarRating(index: index)
        placeRating.text = String(viewModel.getStarRating(index: index))
        placeWeather.image = viewModel.getWeather(index: index)
    }
    
    //head to apple maps
    @IBAction func visitButton(_ sender: Any) {
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        
        let address = viewModel.getaddressFor(index: index)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    print("Location not found")
                    return
            }
            
            // Use your location
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            let regionDistance:CLLocationDistance = 10000
            
            let coordinates = CLLocationCoordinate2DMake(latitude!, longitude!)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = self.viewModel.getTitleFor(index: self.index)
            mapItem.openInMaps(launchOptions: options)
        }
       
    }
    
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        if currentUser.getFavourites().count <= 0{
            _ = currentUser.addToFavourites(place: viewModel.getPlace(index: index))
            placeFavourite.setImage(UIImage(named: "like"), for: .normal)
        }else if(currentUser.addToFavourites(place: viewModel.getPlace(index: index))){
            placeFavourite.setImage(UIImage(named: "like"), for: .normal)
//            print(currentUser.getFavourites())
        }else{
            placeFavourite.setImage(UIImage(named: "heart"), for: .normal)
            _ = currentUser.removeFavourites(place: viewModel.getPlace(index: index))
        }
    }
    
    
    
    func getFavourite(name:String){
        for place in favourites{
            if place.name == name{
                placeFavourite.setImage(UIImage(named:"like"), for: .normal)
            }
        }
    }
}

