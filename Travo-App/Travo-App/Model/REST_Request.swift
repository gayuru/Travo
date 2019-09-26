//
//  REST_Request.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 26/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import Alamofire

class REST_Request{

    private var _places:[Place]=[]
    
    var places:[Place]{
        return _places
    }
    
    private func getData(_ url: URL)
    {
        AF.request(url).validate().responseJSON(queue: <#T##DispatchQueue#>, options: <#T##JSONSerialization.ReadingOptions#>, completionHandler: <#T##(AFDataResponse<Any>) -> Void#>)
    }


}
