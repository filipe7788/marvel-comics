import SwiftUI

struct HeroesListView: View {
  let heroes: [HeroResume]
  let isLoading: Bool
  let onScrolledAtBottom: () -> Void
  var body: some View {
    List {
      heroList
      if isLoading {
        loadingIndicator
      }
      if heroes.count == 0 && !isLoading {
        emptyScreen
      }
    }
    .background(Color.white)
  }
  
  private var emptyScreen: some View {
    Text("No Itens Found")
      .frame(maxWidth: .infinity, alignment: .center)
  }
  
  private var heroList: some View {
    ForEach(heroes) { hero in
      VStack {
          Text(hero.name ?? "Title not found").font(.title)
      }
      .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
      .onAppear {
        if self.heroes.last == hero {
            self.onScrolledAtBottom()
        }
      }
    }
  }

  private var loadingIndicator: some View {
    ActivityIndicator(isAnimating: .constant(true), style: .large, color: .gray)
      .frame(maxWidth: .infinity, alignment: .center)

  }
}
