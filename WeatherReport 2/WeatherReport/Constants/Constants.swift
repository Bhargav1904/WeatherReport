//
//  Constants.swift
//  WeatherReport
//
//  Created by Bhargav on 4/23/23.
//

import Foundation
import UIKit

final class Constants: NSObject {
    static let sharedInstance = Constants()
    let appId:String = "9d46156b26d31ef15a032169fddfb6d1"
    let locationUrl:String = "http://api.openweathermap.org/geo/1.0/direct?"
    let lalLanUrl:String = "https://api.openweathermap.org/data/2.5/weather?"
    /*
     "http://api.openweathermap.org/geo/1.0/direct?q=London&limit=1&appid=9d46156b26d31ef15a032169fddfb6d1"
     */
    
    private override init() { }
    
    
}
//MARK:- Extension
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
