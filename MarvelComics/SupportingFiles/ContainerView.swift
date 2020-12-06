//
//  ContainerView.swift
//  MarvelComics
//
//  Created by Filipe Cruz on 06/12/20.
//

import SwiftUI

struct ContainerView: View {
    @ObservedObject var viewModel: HeroesListViewModel

    var body: some View {
      HeroesListView(
          heroes: viewModel.state.heroes,
          isLoading: viewModel.state.canLoadNextPage,
          onScrolledAtBottom: viewModel.fetchNextPageIfPossible)
        .onAppear(perform: viewModel.fetchNextPageIfPossible)
    }
}
