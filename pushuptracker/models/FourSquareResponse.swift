//
//  FourSquareResponse.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/19/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import Foundation

struct FourSquareResponse: Codable {
    
    let meta: Meta
    let response: Response
    
}

struct Meta: Codable {
    
    let code: Int
    let requestId: String
    
}

struct Response: Codable {
    
    let venues: [Venues]
    
}

struct Venues: Codable {
    
    let id: String
    let name: String
    let location: Location
    let categories: [Categories]
    let referralId: String
    let hasPerk: Bool
    
}

struct Location: Codable {
    
    let address: String?
    let lat: Double
    let lng: Double
    let distance: Int
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]
    
}

struct Categories: Codable {
    
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: Icon
    let primary: Bool
    
}

struct Icon: Codable {
    
    let prefix: String
    let suffix: String
    
}
