//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//

import SwiftUI
import CachedAsyncImage

struct WeatherView: View {
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    @State var weather: WeatherResult = WeatherResult(id: 0, name: "", coord: Coord(lon: 0.0, lat: 0.0), weather: [], main: Main(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, pressure: 0.0, humidity: 0.0, sea_level: 0.0, grnd_level: 0.0), wind: Wind(speed: 0.0, deg: 0, gust: 0.0))
    
    @State private var currentLocationDisplayed = false
    
    var body: some View {
        VStack {
            if currentLocationDisplayed {
                Text("Current weather at your location.")
            }
            else {
                Text("Current weather in \(weatherVM.selectedCity.name!), \(weatherVM.selectedCity.state!)")
            }
            Divider()
            if weather.id! != 0 {
                HStack {
                    Spacer()
                    Text(weather.weather![0].description!.capitalized)
                    Spacer()
                }
                VStack {
                    HStack {
                        CachedAsyncImage(
                            url: URL(string:
                                        "https://openweathermap.org/img/wn/\(weather.weather![0].icon!)@2x.png")) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                                .padding(5)
                                        } placeholder: {
                                            ProgressView()
                                        }
                        VStack (alignment: .leading) {
                            if let temp = weather.main?.temp {
                                Text("Current Temperature: \(Int(kelvinToFahrenheit(temp)))° F")
                            }
                            if let feels_like = weather.main?.feels_like {
                                Text("Feels Like: \(Int(kelvinToFahrenheit(feels_like)))° F")
                            }
                        }
                    }
                    HStack {
                        if let temp_min = weather.main?.temp_min {
                            Text("Min Temperature: \(Int(kelvinToFahrenheit(temp_min)))° F")
                        }
                        if let temp_max = weather.main?.temp_max {
                            Text("Max Temperature: \(Int(kelvinToFahrenheit(temp_max)))° F")
                        }
                    }
                }
            }
        }
        //updates selected city data when new city is tapped on
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.cityChange)) { object in
            NetworkRequests().getWeatherSearch(lat: weatherVM.selectedCity.lat!, lon: weatherVM.selectedCity.lon!) { data in
                weather = data!
                currentLocationDisplayed = false
            }
        }
        .onAppear {
            //if city selected then load that
            if weatherVM.selectedCity.lon! != 0.0 {
                NetworkRequests().getWeatherSearch(lat: weatherVM.selectedCity.lat!, lon: weatherVM.selectedCity.lon!) { data in
                    weather = data!
                }
            }
            //or if location services enabled load current location weather
            else if weatherVM.currentLat != 0.0 {
                NetworkRequests().getWeatherSearch(lat: weatherVM.currentLat, lon: weatherVM.currentLon) { data in
                    weather = data!
                    currentLocationDisplayed = true
                }
            }
        }
        
    }
}

func kelvinToFahrenheit(_ kelvin: Double) -> Double {
    let fahrenheit = (kelvin - 273.15) * 9/5 + 32
    return fahrenheit
}
