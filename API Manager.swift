//
//  API Manager.swift
//  
//
//  Created by Roman Bezpalov on 29.09.18.
//

import Foundation
import Alamofire

struct SunInfo {
    
    let sunRise: String
    let sunSet: String
    
    init(sunRise: String, sunSet: String){
        self.sunSet = sunSet
        self.sunRise = sunRise
    }
}


class ApiManager {

    let url = URL(string: "https://api.sunrise-sunset.org/json")!
    var sessionManager = SessionManager()

    
    
    func getInfo(lat:String, lng:String, completion: @escaping (SunInfo?) -> Void) {
        
        let paramsDict = ["lat":lat,"lng":lng]

        sessionManager.request(url, method: .get, parameters: paramsDict, encoding: JSONEncoding.default , headers: nil)

        if true == true {
        
        } else {
            completion(nil)
        }
    }

}

