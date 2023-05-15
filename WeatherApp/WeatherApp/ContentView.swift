//
//  ContentView.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//
import SwiftUI

struct ContentView: View {
    @State var location = LocationManager()
    @EnvironmentObject var weatherVM: WeatherViewModel

    @State private var searchText = ""
    @State var cityResults = [LocationSearchResult]()
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            CityList()
        }
        .onAppear {
            //load up user defaults as necesarry
            if !defaults.bool(forKey: "citySelected") {
                location.getLocation { data, error  in
                    weatherVM.currentLat = data?.coordinate.latitude ?? 0.0
                    weatherVM.currentLon = data?.coordinate.longitude ?? 0.0
                }
            }
            else if (defaults.string(forKey: "cityState") != nil) {
                
                weatherVM.selectedCity = LocationSearchResult(name: defaults.string(forKey: "cityName"), state: defaults.string(forKey: "cityState"), lat: defaults.double(forKey: "cityLat"), lon: defaults.double(forKey: "cityLon"))
            }
        }
    }
}


