//
//  LocationSearchResult.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//

import Foundation


struct LocationSearchResult: Codable, Hashable {
    
    let name: String?
    let state: String?
    let lat: Double?
    let lon: Double?
    
}
