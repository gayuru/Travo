//
//  RegisterPopoverViewController.swift
//  Travo-App
//
//  Created by Jun Cheong on 21/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import UIKit

// ViewController Extension for Popover
extension ViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
