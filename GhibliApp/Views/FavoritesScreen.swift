//
//  FavoritesScreen.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 25.11.2025.
//

import SwiftUI

struct FavoritesScreen: View {
    let filmsViewModel: FilmViewModel
    let favoritesViewModel: FavoritesViewModel

    var films: [Film] {
        let favorites = favoritesViewModel.favoriteIDs
        switch filmsViewModel.state {
            case .loaded(let films):
                return films.filter { favorites.contains($0.id) }
            default: return []
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No Favorites yet", systemImage: "heart")
                } else {
                    FilmListView(films: films,  favoritesViewModel: favoritesViewModel)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}


#Preview {
    FavoritesScreen(filmsViewModel: FilmViewModel(service: MockGhibliService()), favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
