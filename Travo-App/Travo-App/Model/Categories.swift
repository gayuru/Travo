//
//  Categories.swift
//  Travo-App
//
//  Created by Jun Cheong on 18/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class Categories {
    private var categoryNameList = ["art", "bar", "beach", "cafe", "coffee", "general", "hike", "library", "monument", "park"]
    private var categoryList:[Category]
    
    init() {
        categoryList = [Category]()
        generateCategories(dictionary: generateImageDictionary())
    }
    
    private func generateCategories(dictionary:[String:String]) {
        for (key, value) in dictionary {
            categoryList.append(Category.init(name: key, image: value))
        }
    }
    
    private func generateImageDictionary()-> [String:String] {
        var nameImageDictionary = [String:String]()
        for name in categoryNameList {
            nameImageDictionary.updateValue("category_\(name)", forKey: name)
        }
        return nameImageDictionary
    }
    
    func getCategoryList()-> [Category] {
        return self.categoryList
    }
    
    func getCategoryByName(name: String)->Category? {
        for category in categoryList {
            if (category.getName() == name) {
                return category
            }
        }
        return nil
    }
    
    func getEnabledImageFromCategory(name: String)->String? {
        guard let category = getCategoryByName(name: name) else { return nil }
        return ("\(category.getImage())_enabled")
    }
}
