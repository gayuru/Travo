//
//  CategoryViewModel.swift
//  Travo-App
//
//  Created by Jun Cheong on 18/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class CategoryViewModel {
    private var categories:Categories
    private var categoryList:[Category]
    
    init() {
        categories = Categories.init()
        categoryList = categories.getCategoryList()
    }
    
    func getCategories() -> [Category]{
        return categoryList
    }
    
    func getCategoryByName(name: String)->Category? {
        return categories.getCategoryByName(name: name)
    }
    
    func getCategoryEnabledImage(name: String)->String? {
        return categories.getEnabledImageFromCategory(name: name)
    }
    
    func getCategoryImage(name: String)->String? {
        return categories.getCategoryByName(name: name)?.getImage()
    }
}
