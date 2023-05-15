//
//  WeatherResult.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//

import Foundation


struct WeatherResult: Codable, Hashable {
    
    static func == (lhs: WeatherResult, rhs: WeatherResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int?
    let name: String?
    let coord: Coord?
    let weather: [WeatherWrapper]?
    let main: Main?
    let wind: Wind?
}
