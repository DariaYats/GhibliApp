//
//  ContentView.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 11.11.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen()
            }

            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen()
            }

            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }

            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
