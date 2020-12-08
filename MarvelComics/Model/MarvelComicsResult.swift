//
//  MarvelComicsResult.swift
//  MarvelComics
//
//  Created by Filipe Cruz on 06/12/20.
//

import Foundation

public struct MarvelComicsResult: Codable {
    
  public let offset: Int
  public let limit: Int
  public let total: Int
  public let count: Int
  var results: [HeroResume] 
    
  enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}
