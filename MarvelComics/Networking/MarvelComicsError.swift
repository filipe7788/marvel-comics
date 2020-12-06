import Foundation

enum MarvelComicsError: Error {
  case parsing(description: String)
  case network(description: String)
}
