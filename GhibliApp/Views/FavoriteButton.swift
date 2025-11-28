//
//  FavoriteButton.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 27.11.2025.
//

import SwiftUI

struct FavoriteButton: View {

    let filmID: String
    let favoritesViewModel: FavoritesViewModel

    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: filmID)
    }

    var body: some View {
        Button {
            favoritesViewModel.toggleFavorite(filmID: filmID)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? Color.pink : Color.gray)
        }
    }
}
