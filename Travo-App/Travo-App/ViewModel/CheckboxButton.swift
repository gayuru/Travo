//
//  CheckboxButton.swift
//  Travo-App
//
//  Created by Jun Cheong on 12/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class CheckboxButton: UIButton {
    
    //CheckBox Images
    let checkMark = UIImage(named: "checked_checkbox")! as UIImage
    let emptyCheckMark = UIImage(named: "unchecked_checkbox")! as UIImage
    
    var checked:Bool = false {
        didSet{
            if checked == true {
                self.setImage(checkMark, for: UIControl.State.normal)
            } else {
                self.setImage(emptyCheckMark, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.checked = false
    }
    
    @objc
    func buttonClicked(sender: UIButton) {
        if sender == self {
            checked = !checked
        }
    }
}
