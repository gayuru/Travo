//
//  UnderlinedTextField.swift
//  Travo-App
//
//  Created by Jun Cheong on 21/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class UnderlinedTextField: UITextField {

    var underline = UIView()
    
    override func awakeFromNib() {

        self.translatesAutoresizingMaskIntoConstraints = false
        
        underline = UIView.init(frame: CGRect(x: 0, y:0, width: 0, height: 0))
        // Underline color
        underline.backgroundColor = UIColor.lightGray
        underline.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(underline)
        
        underline.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        underline.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        underline.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        underline.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}
