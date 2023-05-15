//
//  CityList.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//

import Foundation
import SwiftUI

struct CityList: View {
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    @State private var searchText = ""
    @State var cityResults = [LocationSearchResult]()
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            List {
                SearchBarWrapper(searchText: $searchText, onSearchButtonClicked: performSearch)
                    .frame(height: 50)
                ForEach(cityResults, id: \.self) { result in
                    Button(action: {
                        defaults.set(true, forKey: "citySelected")
                        weatherVM.selectedCity = result
                        NotificationCenter.default.post(name: NSNotification.cityChange, object: nil)
                        defaults.set(result.name!, forKey: "cityName")
                        defaults.set(result.state!, forKey: "cityState")
                        defaults.set(result.lat!, forKey: "cityLat")
                        defaults.set(result.lon!, forKey: "cityLon")
                    })
                    {
                        HStack {
                            Text("\(result.name!), \(result.state!)")
                            Spacer()
                            Image(systemName: "sun.haze.fill")
                        }
                    }
                }
            }
            
            if weatherVM.selectedCity.name != nil && !weatherVM.selectedCity.name!.isEmpty || weatherVM.currentLat != 0.0 {
                WeatherView()
            }
        }
    }
    
    func performSearch() {
        // Implement your logic when the search button is clicked
        NetworkRequests().getCoordinates(city: searchText) { data in
            if let data {
                cityResults = data
            }
        }
    }
}

extension View {
    func addSearchBar(searchText: Binding<String>, onSearchButtonClicked: (() -> Void)? = nil) -> some View {
        self.modifier(SearchBarModifier(searchText: searchText, onSearchButtonClicked: onSearchButtonClicked))
    }
}

struct SearchBarModifier: ViewModifier {
    @Binding var searchText: String
    var onSearchButtonClicked: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                SearchBarWrapper(searchText: $searchText, onSearchButtonClicked: onSearchButtonClicked)
                    .frame(height: 50)
            )
    }
}
