//
//  API Manager.swift
//
//
//  Created by Roman Bezpalov on 29.09.18.


import Foundation
import Alamofire
import SwiftyJSON

struct SunInfo {
    
    let sunRise: String
    let sunSet: String
    
    init(sunRise: String, sunSet: String){
        self.sunSet = sunSet
        self.sunRise = sunRise
    }
}


class ApiManager: NSObject {
    
    static let shared = ApiManager() // singelton

    let baseUrl = URL(string: "https://api.sunrise-sunset.org/json")!
   
    
    
    var sessionManager = SessionManager()
    
    func parseSunInfo(json:JSON) -> SunInfo {
        
        let result = json["results"]
        let sunRise = result["sunrise"].stringValue
        let sunSet = result["sunset"].stringValue
        return SunInfo(sunRise: sunRise, sunSet: sunSet)
    }
    

    
    func getInfo(lat:Float, lng:Float, completion: @escaping (SunInfo?) -> Void) {
        
        let paramsDict = ["lat":lat, "lng":lng]

        sessionManager.request(baseUrl, method: .get, parameters: paramsDict, encoding: JSONEncoding.default , headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                   
                case.failure(let error):
                    completion(nil)
                    print("Success with error: \(error)")
                    
                case.success(let value):
                    guard let json = value as? JSON else { completion(nil); return }
                    let sunInfoModel = self.parseSunInfo(json: json)
                    completion(sunInfoModel)
                    print("Success with vaule: \(json)")
                }
        }
        
        
        
        
    }
}

                
                
                    
//                    let lat = response.object(forKey: "lat")
//                    let lng = response.object(forKey: "lng")
//
//                case .success(let vaule):
//                    guard let json = vaule as? [String:AnyObject] else{
//                        NSAllert.okWithMessage
////                        NSAlert.okWithMessage("Failed to get expected response from webserver.")
//                        return
//            }
//        }
//    }
//}

                
                //                if let responseVaule = response.result.value as! String? {
//                    print(responseVaule)
//
//                }
                
//                                switch response.result {
//                case .success(let vaule):
//                    print(vaule)
//
//                case .failure(let error):
//                    print(error)
//
//
//
//
//
//                }












