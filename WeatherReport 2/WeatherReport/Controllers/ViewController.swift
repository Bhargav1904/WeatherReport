//
//  ViewController.swift
//  WeatherReport
//
//  Created by Bhargav on 4/23/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputCityTxt:UITextField!
    @IBOutlet weak var tb:UITableView!
    lazy var viewModel = {
        LocationWeatherViewModel(WeatherService: WeatherService())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSubmit(sender:UIButton){
        if viewModel.checkingInputCityfield(cityName: self.inputCityTxt.text){
            
            viewModel.getWeather(cityName: self.inputCityTxt.text ?? "")
        }
        
        viewModel.reloadTableView = {
            [weak self] in
            DispatchQueue.main.async {
                self?.tb.reloadData()
            }}
        
    }
}

//MARK:-UITableViewDataSource,UITableViewDelegate
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.viewModel.WeahterModeldata{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as? DetailsTableViewCell{
            if let model = self.viewModel.WeahterModeldata{
                cell.DescriptionLbl.text = """
cityName :- \(model.name ?? ""),\nCountryname :- \(model.sys?.country ?? ""),\nDescription:- \(model.weather?[0].description ?? "")
"""
                if let url = URL(string: "https://openweathermap.org/img/wn/\(model.weather?[0].icon ?? "" )@2x.png"){
                    cell.icon.load(url:url)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}



