//
//  LocationWeatherViewModel.swift
//  WeatherReport
//
//  Created by Bhargav on 4/23/23.
//

import Foundation
typealias WeahterModels = [WeahterModel]
class LocationWeatherViewModel: NSObject {
    private var WeatherService: WeatherServiceProtocol
    var urlStr:String = ""
    //    var displayStr:String = ""
    init(WeatherService: WeatherServiceProtocol) {
        self.WeatherService = WeatherService
    }
    
    var reloadTableView: (() -> Void)?
    var WeahterModeldata :WeahterModel? = nil
    

    
    var displayStr = String() {
        didSet {
            reloadTableView?()
        }
    }
    
    func getfullUrl(Str:String)-> String{
        let nameStr:String = "q=\(Str)"
        let limitandApid = "&limit=1&appid=\(Constants.sharedInstance.appId)"
        //http://api.openweathermap.org/geo/1.0/direct?q=London&limit=1&appid=9d46156b26d31ef15a032169fddfb6d1
        return (Constants.sharedInstance.locationUrl + nameStr) + limitandApid
    }
    
    //https://api.openweathermap.org/data/2.5/weather?lat=4.80088935&lon=-75.69149658133686&appid=9d46156b26d31ef15a032169fddfb6d1
    
    func getLatLanUrl(lat:Double?,lan:Double?) -> String{
        guard let lan = lan, let lat = lat else{ return ""}
        let latStr = "lat=\(String(describing: lat))"
        let lanStr = "&lon=\(String(describing: lan))"
        return Constants.sharedInstance.lalLanUrl + ((latStr + lanStr) + ("&appid=" + Constants.sharedInstance.appId))
    }
    func getWeather(cityName:String) {
        WeatherService.getWeatherService(urlStr:getfullUrl(Str: cityName)) { success, model, error in
            if success, let location = model,
               !location.isEmpty {
                print(location)
                if self.checkingIsUs(LocationModel: location[0]){
                    
                    self.WeatherService.getWeatherBasedLatLon(
                        urlStr: self.getLatLanUrl(lat: location[0].lat, lan: location[0].lon)) { success, results, error in
                            if success,let results = results{
                                print("reslut\(results)")
                                self.displayStr = "\(results)"
                                //                                self.WeahterModeldata = res
                                self.WeahterModeldata = results
                                //
                            }
                            else if let error = error{
                                print(error)
                                self.displayStr = "\(error)"
                            }
                        }
                }
                else{
                    //                    self.displayStr = "this location not belong to US,but it is belong to \(location[0].country ?? "")"
                }
                
            } else if let error = error{
                print(error)
                self.displayStr = "\(error)"
            }
        }
    }
    func getCallWeatherLatLonCity(){
        
    }
    func checkingInputCityfield(cityName:String?)->Bool{
        guard let cityName = cityName else {
            //            self.displayStr = "Please enter city name,country name,Pincode"
            return false}
        return cityName.isEmpty ? false : true
        
    }
    func checkingIsUs(LocationModel:LocationModel?)-> Bool{
        guard let LocationModel = LocationModel else{return false}
        return LocationModel.country == "US" ? true : false
    }
}
