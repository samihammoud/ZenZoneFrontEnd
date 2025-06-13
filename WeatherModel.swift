//
//  WeatherModel.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/3/24.

//map the JSON response from a weather API into  structured Swift-native format.

import Foundation

struct WeatherModel: Codable {
    let location: Location
    let current: CurrentWeather
}

struct Location: Codable {
    let tz_id: String
    //let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temp_c: Float
    let condition: WeatherInfo
}

struct WeatherInfo: Codable {
    let text: String
    let icon: String
}
