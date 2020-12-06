//
//  HeroImageAPI.swift
//  MarvelComics
//
//  Created by Filipe Cruz on 06/12/20.
//

import Foundation

public struct HeroImageAPI: Codable, Identifiable {
    public let id = UUID()
    public let fileExtension: String
    
    private var _path: String!
    public var path: String? {
        return self.securePath(path: _path)
    }
    
    public var url: URL? {
        return URL(string: self.securePath(path: self._path) + "." + self.fileExtension)
    }
    
    
    func securePath(path:String) -> String {
        if path.hasPrefix("http://") {
            let range = path.range(of: "http://")
            var newPath = path
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return path
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _path = "path"
        case fileExtension = "extension" 
    }
    
}
