//
//  Category.swift
//  Travo-App
//
//  Created by Jun Cheong on 18/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class Category {
    private var name:String
    private var image:String
    
    init(name:String, image:String) {
        self.name = name
        self.image = image
    }
    
    func getName()->String {
        return self.name
    }
    
    func getImage()->String {
        return self.image
    }
}
