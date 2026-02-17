//
//  HomeView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/4/24.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var meditationHandler: MeditationHandler
    @State private var searchText = ""

    var body: some View {
        BackgroundWrapper {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Header()
                        Search(searchText: $searchText)
                            .padding(10)
                        TrendingMeditationView(meditationHandler: meditationHandler)
                        // Filtered Results Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(filteredMeditations) { meditationVM in
                                    RoutineCardView(meditationVM: meditationVM, meditationHandler: meditationHandler)
                                }
                            }
                        }
                        
                        // "Today's Rec" Section
                        if let recommendation = meditationHandler.meditationArray.first {
                            VStack {
                                Text("Zen's Rec")
                                    .font(.largeTitle) // Bigger size
                                    .fontWeight(.bold) // Bold font
                                    .multilineTextAlignment(.center) // Center alignment
                                    .padding(.bottom, 6) // Space below the text
                                    .foregroundColor(.white)

                                RoutineCardView(
                                    meditationVM: recommendation,
                                    meditationHandler: meditationHandler
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .center) // Ensure VStack is centered
                        }

                        
                        Spacer()
                    }
                    .padding(35)
                    .safeAreaInset(edge: .top, spacing: 0) {
                        Color.clear.frame(height: 20)
                    }
                }
            }
        }
    }

    // Computed property to filter meditations based on the searchText
    private var filteredMeditations: [MeditationViewModel] {
        let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedQuery.isEmpty {
            return meditationHandler.meditationArray
        } else {
            return meditationHandler.meditationArray.filter {
                $0.meditation.title.localizedCaseInsensitiveContains(trimmedQuery)
            }
        }
    }

    // Search Component
    struct Search: View {
        @Binding var searchText: String
        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.white)
                TextField("Search...", text: $searchText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .accentColor(.white)
                    .bold()
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(30)
        }
    }

    // See More Component
    struct TrendingMeditationView: View {
        @ObservedObject var meditationHandler: MeditationHandler
        var body: some View {
            NavigationLink(destination: SeeMoreMeditationsView(meditationHandler: meditationHandler)) {
                Text("Trending Meditations")
                    .font(.title2) // Make the text larger
                    .fontWeight(.bold) // Bold font
                    .foregroundColor(.white)
                    .padding() // Add padding inside the border
                    .cornerRadius(40) // Rounded corners
                    .padding(.horizontal, 10) // Add padding outside the border
            }
        }
    }
}


#Preview {
    HomeView(meditationHandler: MeditationHandler())
}
