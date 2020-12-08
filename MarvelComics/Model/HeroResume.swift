//
//  HeroResume.swift
//  MarvelComics
//
//  Created by Filipe Cruz on 06/12/20.
//

import Foundation

struct HeroResume: Codable, Equatable, Identifiable {
  public let id: Int?
  public let name: String?
  public let description: String?
  public let thumbnail: HeroImageAPI
  
  public var expand:Bool = false
  enum CodingKeys: String, CodingKey {
      case id = "id"
      case name = "name"
      case description = "description"
      case thumbnail = "thumbnail"
  }
  
  static func == (lhs: HeroResume, rhs: HeroResume) -> Bool {
    lhs.id == rhs.id
  }
  
}
