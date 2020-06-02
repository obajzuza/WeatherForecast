//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Guest User on 10.03.2020.
//  Copyright © 2020 Guest User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // http://www.appsdeveloperblog.com/http-get-request-example-in-swift/
        //utworzenie URL
        let weatherUrl = URL(string: "https://api.darksky.net/forecast/c0824ec478fa2c341e20fa48d0759f54/37.8267,-122.4233?exclude=minutely,hourly,alerts,flags&lang=pl")
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
                        
                        // Print out entire dictionary
                        print(dataDict)
                        
                        // Get value by key
                        // let userId = dataDict["userId"]
                        // print(userId ?? "userId could not be read")
                        
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }


}

