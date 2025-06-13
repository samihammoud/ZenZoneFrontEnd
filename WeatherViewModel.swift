//
//  WeatherViewModel.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/3/24.
//

import Foundation

@Observable class WeatherViewModel{
    // Properties to be updated, automatically reflecting in the view
     var title: String = "-"
     var description: String = "-"
     var temperature: String = "-"
     var timeZone: String = "-"
     var imageURL: String = "-"

    
    init() {
        fetchWeather()
    }
    
    func fetchWeather() {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=0e69573d448047a4b14184851242111&q=London"
) else {
            print("Invalid API URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return } // Avoid retain cycles
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Decode the data into the model
            do {
                let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self.title = model.location.tz_id
                    self.description = model.current.condition.text
                    self.temperature = "\(model.current.temp_c)°"
                    self.timeZone = model.location.tz_id
                    self.imageURL = "https:\(model.current.condition.icon)"
                    print("Title: \(self.title)")
                    print("Temperature: \(self.temperature)")
                }
            } catch {
                print("Failed to decode weather data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}


