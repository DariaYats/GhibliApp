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

    var state: LadingState<[Film]> = .idle

    private let service: GhibliService
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetch() async {
        guard !state.isLoading || state.error != nil  else { return }
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

    // MARK: - Preview

        static var example: FilmViewModel {
            let vm = FilmViewModel(service: MockGhibliService())
            vm.state = .loaded([Film.example, Film.exampleFavorite])
            return vm
        }

}
