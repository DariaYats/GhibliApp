//
//  FilmsScreen.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 25.11.2025.
//

import SwiftUI

struct FilmsScreen: View {
    let filmsViewModel: FilmViewModel
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No Films yet")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                        .navigationDestination(for: Film.self) { film in
                            FilmDetailScreen(film: film, favoritesViewModel: favoritesViewModel)
                        }
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.pink)
                }
            }
            .navigationTitle("Ghibli Movies")
        }
    }
}

#Preview {
    FilmsScreen(filmsViewModel: FilmViewModel(service: MockGhibliService()), favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
