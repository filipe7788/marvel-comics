//
//  StringExtension.swift
//  MarvelComics
//
//  Created by Filipe Cruz on 06/12/20.
//

import Foundation
import CryptoKit

extension String {
  var md5: String {
    let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
  }
}
