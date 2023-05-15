//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(weatherVM)
        }
    }
}
