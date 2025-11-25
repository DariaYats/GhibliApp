//
//  FilmViewModel.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 11.11.2025.
//

import Foundation
import Observation

@Observable
class FilmViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }

    var state: State = .idle
    var films: [Film] = []

    private let service: GhibliService
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetch() async {
        guard state == .idle else { return }
        state = .loading

        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.localizedDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}
