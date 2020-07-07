//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Guest User on 10.03.2020.
//  Copyright © 2020 Guest User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var maxTValue: UILabel!
    @IBOutlet weak var minTValue: UILabel!
    @IBOutlet weak var precipTypeLabel: UILabel!
    @IBOutlet weak var precipProbabilityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tMax: NSNumber = 20.7
    var tMin: NSNumber = 12.14
    var precipType: String = "rain"
    var precipProbability: NSNumber = 0.52
    var pressure: NSNumber = 1015.9
    var windSpeed: NSNumber = 4.73
    var windDirection: NSNumber = 309
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //utworzenie URL
        let weatherUrl = URL(string: "https://api.darksky.net/forecast/c0824ec478fa2c341e20fa48d0759f54/50.0496,19.9445?exclude=minutely,hourly,alerts,flags&lang=pl&units=si")
        guard let url = weatherUrl else { fatalError() }
        //utowrzenie URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                // print("Response data string:\n \(dataString)")
                do {
                    if let dataDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        
                        let dataData = dataDict["daily"] as? NSDictionary
                        let dataDaily = dataData!["data"] as? NSArray
                        let dataToday = dataDaily![0] as? NSDictionary
                        print(dataToday!)
                        self.tMax = dataToday!["temperatureMax"] as! NSNumber
                        self.tMin = dataToday!["temperatureMin"] as! NSNumber
                        self.pressure = dataToday!["pressure"] as! NSNumber
                        self.precipType = dataToday!["precipType"] as! String
                        self.precipProbability = dataToday!["precipProbability"] as! NSNumber
                        self.windSpeed = dataToday!["windSpeed"] as! NSNumber
                        self.windDirection = dataToday!["windBearing"] as! NSNumber
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
       DispatchQueue.main.async {
            self.maxTValue.text = self.tMax.stringValue
            self.minTValue.text = self.tMin.stringValue
            self.precipTypeLabel.text = self.precipType
            self.precipProbabilityLabel.text = self.precipProbability.stringValue
            self.pressureLabel.text = self.pressure.stringValue
            self.windSpeedLabel.text = self.windSpeed.stringValue
            self.windDirectionLabel.text = self.windDirection.stringValue
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.string(from: Date())
            self.dateLabel.text = date
        }
    }


}

