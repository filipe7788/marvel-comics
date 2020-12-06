import Foundation
import Combine

protocol MarvelComicsFetchable {
  func getHeroList(
    page: Int
  ) -> AnyPublisher<MarvelDataSetAPI, MarvelComicsError>

  func getHeroDetail(
    forHero heroId: String
  ) -> AnyPublisher<HeroResume, MarvelComicsError>
}

class MarvelComicsFetcher {
  private let session: URLSession
  static let pageSize = 100

  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - MarvelComics API
private extension MarvelComicsFetcher {
  struct MarvelComicsAPI {
    static let scheme = "https"
    static let host = "gateway.marvel.com"
    static let path = "/v1/public/characters"
    static let publicKey = "2e32269b941eabb73f77184484d79593"
    static let privateKey = "c0c20fb83acc21578ed97ea14629e37d313f040d"
    static let ts = NSDate().timeIntervalSince1970.description
  }
  
  func makeHeroesListComponents(
    page: Int
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = MarvelComicsAPI.scheme
    components.host = MarvelComicsAPI.host
    components.path = MarvelComicsAPI.path

    components.queryItems = [
      URLQueryItem(name: "apikey", value: MarvelComicsAPI.publicKey),
      URLQueryItem(name: "ts", value: MarvelComicsAPI.ts),
      URLQueryItem(name: "limit", value: String(MarvelComicsFetcher.pageSize)),
      URLQueryItem(name: "offset", value: String(page*MarvelComicsFetcher.pageSize)),
      URLQueryItem(name: "hash", value: (MarvelComicsAPI.ts + MarvelComicsAPI.privateKey + MarvelComicsAPI.publicKey).md5),
    ]
    
    return components
  }
  
  func makeHeroesDetailsComponents(
    forHero heroId: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = MarvelComicsAPI.scheme
    components.host = MarvelComicsAPI.host
    
    components.queryItems = [
      URLQueryItem(name: "heroId", value: heroId),
      URLQueryItem(name: "mode", value: "json"),
      URLQueryItem(name: "units", value: "metric"),
      URLQueryItem(name: "apikey", value: MarvelComicsAPI.publicKey)
    ]
    
    return components
  }
}

// MARK: - WeatherFetchable
extension MarvelComicsFetcher: MarvelComicsFetchable {

  func getHeroList(page: Int) -> AnyPublisher<MarvelDataSetAPI, MarvelComicsError> {
    return getHero(with: makeHeroesListComponents(page: page))
  }

  func getHeroDetail(forHero heroId: String) -> AnyPublisher<HeroResume, MarvelComicsError> {
    return getHero(with: makeHeroesDetailsComponents(forHero: heroId))
  }

  private func getHero<T>(with components: URLComponents) -> AnyPublisher<T, MarvelComicsError> where T: Decodable {
    guard let url = components.url else {
      let error = MarvelComicsError.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }
    return session.dataTaskPublisher(for: URLRequest(url: url))
      .mapError { error in
        .network(description: error.localizedDescription)
      }
      .flatMap(maxPublishers: .max(1)) { pair in
        decode(pair.data)
      }
      .eraseToAnyPublisher()
  }
}
