//
//  CardView.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 20/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {

    @IBInspectable var cornerradius : CGFloat = 15
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerradius
        
//        layer.backgroundColor = backColor as! CGColor
        
    }
    
    
}
