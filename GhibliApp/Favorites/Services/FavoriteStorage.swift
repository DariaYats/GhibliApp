//
//  FavoriteStorage.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 26.11.2025.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
