//
//  GhibliService.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 11.11.2025.
//

import Foundation

protocol GhibliService: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPerson(from URLString: String) async throws -> Person
}
