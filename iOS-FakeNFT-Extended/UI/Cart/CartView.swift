import SwiftUI

struct CartView: View {
    struct CartNFT: Identifiable {
        let id = UUID()
        let name: String
        let price: String
        let rating: Int
    }
    
    let nfts: [CartNFT]
    
    init(nfts: [CartNFT] = []) {
        self.nfts = nfts
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.ypWhiteUniversal
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: .zero) {
                    Color.clear
                        .frame(height: 46)
                    
                    if nfts.isEmpty {
                        emptyCartView
                    } else {
                        nftListView
                    }
                }
            }
            navBarView
            if !nfts.isEmpty {
                bottomPanelView
            }
        }
    }
    
    // MARK: - Subviews
    private var emptyCartView: some View {
        VStack(spacing: 8) {
            Text("Корзина пуста")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)
                .frame(height: 22)
                .frame(width: 343)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 351)
    }
    
    private var nftListView: some View {
        ForEach(nfts) { nft in
            Rectangle()
                .fill(.ypRedUniversal.opacity(0.1)) // Заглушка - будет реальная ячейка
                .frame(height: 140)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
    }
    
    private var navBarView: some View {
        VStack(spacing: .zero) {
            HStack {
                Spacer()
                
                Button(action: {}) {
                    Image("sort")
                        .resizable()
                        .foregroundColor(.ypBlack)
                        .frame(width: 42, height: 42)
                }
                .padding(.trailing, 9)
            }
            .frame(height: 44)
            .background(Color.ypWhiteUniversal)
            
            Spacer()
        }
    }
    
    private var bottomPanelView: some View {
        VStack(spacing: .zero) {
            Spacer()
            
            VStack(spacing: 10) {
                HStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(nfts.count) NFT")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.ypBlack)
                            .frame(height: 20)
                        
                        Text("5,34 ETH")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.ypGreenUniversal)
                            .frame(height: 22)
                    }
                    .frame(width: 79, height: 44)
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("К оплате")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 240, height: 44)
                            .background(.ypBlack)
                            .cornerRadius(16)
                    }
                    .padding(.trailing, 16)
                }
            }
            .padding(.vertical, 16)
            .padding(.bottom, 16)
            .background(.ypLightGrey)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    topTrailingRadius: 12
                )
            )
        }
    }
}

// MARK: - Previews
#Preview("Пустая корзина") {
    CartView()
}

#Preview("Заполненная корзина") {
    let filledNFTs = [
        CartView.CartNFT(name: "April", price: "1,78 ETH", rating: 1),
        CartView.CartNFT(name: "Greena", price: "1,78 ETH", rating: 3),
        CartView.CartNFT(name: "Spring", price: "1,78 ETH", rating: 5),
        CartView.CartNFT(name: "Summer", price: "2,15 ETH", rating: 4),
        CartView.CartNFT(name: "Autumn", price: "0,89 ETH", rating: 2),
        CartView.CartNFT(name: "Winter", price: "3,42 ETH", rating: 5),
        CartView.CartNFT(name: "Ocean", price: "1,25 ETH", rating: 3),
        CartView.CartNFT(name: "Mountain", price: "2,75 ETH", rating: 4)
    ]
    
    return CartView(nfts: filledNFTs)
}
