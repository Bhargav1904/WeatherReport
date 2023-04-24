//
//  WeatherServices.swift
//  WeatherReport
//
//  Created by Bhargav on 4/23/23.
//

import Foundation
import Foundation

protocol WeatherServiceProtocol {
    func getWeatherService(urlStr:String,completion: @escaping (_ success: Bool, _ results: Location?, _ error: String?) -> ())
    
    func getWeatherBasedLatLon(urlStr:String,completion: @escaping (_ success: Bool, _ results: WeahterModel?, _ error: String?) -> ())
}

class WeatherService: WeatherServiceProtocol {
    
    func getWeatherService(urlStr: String, completion: @escaping (Bool, Location?, String?) -> ()) {
        HttpRequestHelper().GET(url: urlStr, params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Location.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Location to model")
                }
            } else {
                completion(false, nil, "Error: Location GET Request failed")
            }
        }
    }
    
    func getWeatherBasedLatLon(urlStr:String,completion: @escaping (Bool, WeahterModel?, String?) -> ()) {
        HttpRequestHelper().GET(url: urlStr, params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(WeahterModel.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse WeahterModel to model")
                }
            } else {
                completion(false, nil, "Error: Weahter GET Request failed")
            }
        }
    }
}
