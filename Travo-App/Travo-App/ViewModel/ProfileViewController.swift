//
//  ProfileViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 16/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
  
    @IBOutlet var profileBackground: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var cityCollection: UICollectionView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var currentCityLabel: UILabel!
    @IBOutlet var intresetsLabel: UILabel!
    var currentUser:User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentUser)
        // Do any additional setup after loading the view.
        profileImage.frame = CGRect(x: 0,y: 0,width: 100,height: 100)
        profileBackground.layer.cornerRadius = 20
        cityCollection.delegate = self
        cityCollection.dataSource = self
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath) as! CityVisitedCollectionViewCell
        cell.cityView.backgroundColor = UIColor.gray
        cell.cityLabel.text = "Melbourne"
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
