import Foundation
import Combine

class HeroesListViewModel: ObservableObject {
  @Published private(set) var state = State()
  private var subscriptions = Set<AnyCancellable>()

  func fetchNextPageIfPossible() {
    guard state.canLoadNextPage else { return }
    MarvelComicsFetcher().getHeroList(page: state.page)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: onReceive,
              receiveValue: onReceive)
        .store(in: &subscriptions)
  }
  
  private func onReceive(_ completion: Subscribers.Completion<MarvelComicsError>) {
      switch completion {
      case .finished:
          break
      case .failure:
        state.heroes = []
        state.canLoadNextPage = false
      }
  }
  
  private func onReceive(_ batch: MarvelDataSetAPI) {
    state.heroes += batch.data.results
    state.page += 1
    state.canLoadNextPage = batch.data.count == MarvelComicsFetcher.pageSize
  }
  
}

struct State {
    var heroes: [HeroResume] = []
    var page: Int = 0
    var canLoadNextPage = true
}
