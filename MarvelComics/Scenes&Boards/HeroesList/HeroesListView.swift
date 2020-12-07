import SwiftUI

struct HeroesListView: View {
  let heroes: [HeroResume]
  let isLoading: Bool
  let onScrolledAtBottom: () -> Void
  
  
  var body: some View {
    ScrollView {
      heroList
      if isLoading {
        loadingIndicator
      }
      if heroes.count == 0 && !isLoading {
        EmptyScreen()
      }
    }
  }

  private var heroList: some View {
    ForEach(heroes) { hero in
      HeroesRow(hero: hero)
      .onAppear {
        if self.heroes.last == hero {
            self.onScrolledAtBottom()
        }
      }
    }
    .background(Color.white)
  }

  private var loadingIndicator: some View {
    ActivityIndicator(isAnimating: .constant(true), style: .large, color: .gray)
      .frame(maxWidth: .infinity, alignment: .center)
  }
}
