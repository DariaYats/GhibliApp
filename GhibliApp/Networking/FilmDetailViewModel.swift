//
//  FilmDetailViewModel.swift
//  GhibliApp
//
//  Created by Daria Yatsyniuk on 11.11.2025.
//

import Foundation
import Observation

@Observable
class FilmDetailViewModel {
    var state: LadingState<[Person]> = .idle

    private  let service: GhibliService

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetchPeople(for film: Film) async  {

    }

    func fetch(for film: Film) async {
        guard !state.isLoading else { return }
        state = .loading
        var loadedPeople: [Person] = []

        do {
            try await withThrowingTaskGroup(of: Person.self) { group in

                for personInfoURL in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: personInfoURL)
                    }
                }

                // collect results as they complete
                for try await person in group {
                    loadedPeople.append(person)
                }
            }

            state = .loaded(loadedPeople)

        }  catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}


import Playgrounds

#Playground {
    let service = MockGhibliService()
    let vm = FilmDetailViewModel(service: service)

    let film = service.fetchFilm()
    await vm.fetch(for: film)

    switch vm.state {
    case .loading: print("Loading...")
    case .idle: print("idle")
    case .loaded(let people):
        for person in people {
            print(person)
        }
    case .error(let error): print (error)
    }
}
