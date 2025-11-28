//
//  DefaultFavoriteStorage.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 26.11.2025.
//

import Foundation

struct DefaultFavoriteStorage: FavoriteStorage {
    private let favoritesKey = "GnibliExplorer.FavoriteFilms"
    
    func load() -> Set<String> {
        let array =  UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return  Set(array)
    }

    func save(favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey)
    }
}
