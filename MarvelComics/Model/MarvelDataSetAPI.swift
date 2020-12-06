//
//  MarvelDataSetAPI.swift
//  MarvelComics
//
//  Created by Filipe Cruz on 06/12/20.
//

import Foundation

public struct MarvelDataSetAPI: Codable {
  public let code: Int?
  public let status: String?
  public let attributionText: String?
  
  public let data: MarvelComicsResult
    
  enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case attributionText = "attributionText"
        case data = "data"
    }
}
