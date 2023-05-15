//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//

import Foundation

//used to keep track of selected city across multiple files and update as needed

class WeatherViewModel: ObservableObject {
    @Published var selectedCity: LocationSearchResult = LocationSearchResult(name: "", state: "", lat: 0.0, lon: 0.0)
    
    @Published var currentLat = 0.0
    
    @Published var currentLon = 0.0
}
