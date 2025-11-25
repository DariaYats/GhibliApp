//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 11.11.2025.
//

import SwiftUI

struct FilmListView: View {
    var filmViewModel = FilmViewModel()
    
    var body: some View {
        NavigationStack {
            switch filmViewModel.state {
            case .idle:
                Text("No Films yet")
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let films):
                List(films) { film in
                    NavigationLink(value: film) {
                        HStack {
                            FilmImageView(urlPath: film.image)
                                .frame(width: 100, height: 150)
                        }
                        Text(film.title)
                    }
                }
                .navigationDestination(for: Film.self) { film in
                    FilmDetailScreen(film: film)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
            }
        }
        .task {
            await filmViewModel.fetch()
        }
    }
}

#Preview {
    @State @Previewable var vm = FilmViewModel(service: MockGhibliService())
    
    FilmListView(filmViewModel: vm)
}
