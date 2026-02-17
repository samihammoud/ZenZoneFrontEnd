//
//  ContentView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/2/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var meditationHandler = MeditationHandler()

    @State private var selection = 1

    var body: some View {
        NavigationView {
            BackgroundWrapper {
                TabView(selection: $selection) {
                    // Tab 1: Home
                    HomeView(meditationHandler: meditationHandler)
                        .tabItem {
                            Image(systemName: "house.fill")
                        }
                        .tag(1)

                    // Tab 2: Favorites
                    FavoritesView(meditationHandler: meditationHandler)
                        .tabItem {
                            Image(systemName: "star.fill")
                        }
                        .tag(2)

                    // Tab 3: Chat
                    ChatUIView()
                        .tabItem {
                            Image(systemName: "quote.bubble")
                        }
                        .tag(3) // Correct placement within TabView
                }
            }
            .modifier(TabBarAppearanceModifier()) // Apply custom tab bar appearance
        }
    }
}


struct Header: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text("Namaste, ")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                Text("Sami")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(Color.white))
            }
            Spacer()
            Image("buddhaheader")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .cornerRadius(100)
        }
    }
}





struct BackgroundWrapper<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Image("bluestars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 9)
            GlisteningStarsView(starCount: 40, maxStarSize: 4)
            
            
            content // Overlay child views
        }
    }
}

struct WeatherView: View {
    //Use State with simple one view lifecycles,
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.imageURL), scale: 0.9)
            Text(viewModel.timeZone).font(.title)
                .foregroundColor(Color.white)
            Text(viewModel.temperature)
                .foregroundColor(Color.white)
            Text(viewModel.description).font(.title3)
                .foregroundColor(Color.white)
            
            //removes any characters not in 0123456789., leaving "25"
            if let temperatureValue = Float(viewModel.temperature.filter("0123456789.".contains)) {
                if temperatureValue < 25 {
                    VStack {
                        YouTubePlayerView(videoID: "uX_yfl2ydio")
                            .frame(height: 300)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("It's cold today! Here's a meditation to warm those chakras...")
                            .foregroundColor(.white)
                            .padding()
                            .italic()
                    }
                } else {
                    VStack {
                        YouTubePlayerView(videoID: "2rm1eAYZRBU")
                            .frame(height: 300)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("It's hot today! Here's a meditation to cool those chakras...")
                            .foregroundColor(.white)
                            .padding()
                            .italic()
                    }
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
