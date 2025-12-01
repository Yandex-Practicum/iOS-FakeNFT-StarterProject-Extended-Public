import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Image(.ypProfileIcon)
                    Text("Профиль")
                }
            
            CatalogView()
                .tabItem {
                    Image(.ypCatalogIcon)
                    Text("Каталог")
                }
            
            CartView()
                .tabItem {
                    Image(.ypCartIcon)
                    Text("Корзина")
                }
            
            StatisticsView()
                .tabItem {
                    Image(.ypStatisticsIcon)
                    Text("Статистика")
                }
        }
    }
}

#Preview {
    TabBarView()
}
