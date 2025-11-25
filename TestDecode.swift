import Foundation

struct Film: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String

    let releaseYear: String
    let score: String
    let duration: String
    let image: String
    let bannerImage: String

    let people: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people
        case bannerImage = "movie_banner"
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }
}

let url = URL(string: "https://ghibliapi.vercel.app/films")!
let sem = DispatchSemaphore(value: 0)

URLSession.shared.dataTask(with: url) { data, response, error in
    defer { sem.signal() }
    if let error = error {
        print("network error:", error)
        return
    }
    guard let data = data else {
        print("no data")
        return
    }
    do {
        let films = try JSONDecoder().decode([Film].self, from: data)
        print("decoded films count:", films.count)
    } catch {
        print("decoding error:", error)
    }
}.resume()

sem.wait()
