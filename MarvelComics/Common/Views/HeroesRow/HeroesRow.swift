//
//  HeroesRow.swift
//  MarvelComics
//
//  Created by Filipe Cruz on 06/12/20.
//

import SwiftUI
import URLImage

struct HeroesRow: View {
  var hero: HeroResume
  
  var body: some View {
    VStack {
      
      if let url = hero.thumbnail.url {
        URLImage(url: url) { image in
            image
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
      }
      
      HStack {
        VStack(alignment: .leading) {
          Text(hero.name ?? "Title not found")
            .font(.title)
            .fontWeight(.black)
            .foregroundColor(.black)
            .lineLimit(3)
          Text(hero.description?.uppercased() ?? "")
            .font(.caption)
            .foregroundColor(.black)
            .lineLimit(2)
        }
        .layoutPriority(100)
        Spacer()
      }
    }
    .cornerRadius(10)
    .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
    )
    .padding()
  }
}
