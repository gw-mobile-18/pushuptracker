//
//  FourSquareAPIManager.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/19/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import Foundation

protocol FetchGymsDelegate {
    func gymsFound(_ gyms: [Gym])
    func gymsNotFound()
}

class FourSquareAPIManager {
    
    var delegate: FetchGymsDelegate?
    
    func fetchGyms() {
        var urlComponents = URLComponents(string: "https://api.foursquare.com/v2/venues/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_secret", value: "H20WAGEG5C2YIIP2QJG0CDNMZQ0O0YBECFTUY4ADZQKQCQUS"),
            URLQueryItem(name: "client_id", value: "KUS3LGMRRJVOP14XPVSVHPHZ5HA00AT40FTIEBSYMWTET40F"),
            URLQueryItem(name: "v", value: "20181119"),
            URLQueryItem(name: "ll", value: "38.900140,-77.049447"),
            URLQueryItem(name: "query", value: "gym")
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            print("request complete")
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("response is nil or not 200")
                
                self.delegate?.gymsNotFound()
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                print("data is nil")
                
                self.delegate?.gymsNotFound()
                
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                let fourSquareResponse = try decoder.decode(FourSquareResponse.self, from: data)
                
                //HERE - decoding was successful
                
                var gyms = [Gym]()
                
                for venue in fourSquareResponse.response.venues {
                    let address = venue.location.formattedAddress.joined(separator: " ")
                    
                    let iconPrefix = venue.categories.first?.icon.prefix
                    let iconSuffix = venue.categories.first?.icon.suffix
                    
                    var iconUrl: String? = nil
                    
                    if let iconPrefix = iconPrefix, let iconSuffix = iconSuffix {
                        iconUrl = "\(iconPrefix)44\(iconSuffix)"
                    }
                    
                    let gym = Gym(name: venue.name, address: address, iconUrl: iconUrl)
                    
                    gyms.append(gym)
                }
                
                //now what do we do with the gyms????
                print(gyms)
                
                self.delegate?.gymsFound(gyms)
                
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print("codable failed - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.gymsNotFound()
            }
        }
        
        print("execute request")
        task.resume()
    }
}
