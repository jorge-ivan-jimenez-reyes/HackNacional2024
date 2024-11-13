import SwiftUI

struct SectionView<Destination: View>: View {
    var title: String
    var items: [Item]
    var seeMoreTitle: String
    var seeMoreDestination: Destination
    var isCommunity: Bool = false
    @Binding var isTabBarHidden: Bool  // Control de visibilidad del TabBar

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(150))], spacing: 16) {
                    ForEach(items) { item in
                        NavigationLink(
                            destination: {
                                if isCommunity {
                                    // Navega a NewsView y oculta el TabBar
                                    NewsView(communityName: item.title)
                                        .onAppear { isTabBarHidden = true }
                                        .onDisappear { isTabBarHidden = false }
                                } else if title == "Infografías" {
                                    // Navega a InfografiaView y oculta el TabBar
                                    InfografiaView()
                                        .onAppear { isTabBarHidden = true }
                                        .onDisappear { isTabBarHidden = false }
                                } else {
                                    // Navega a SingleCommunityView y oculta el TabBar
                                    SingleCommunityView(communityName: item.title)
                                        .onAppear { isTabBarHidden = true }
                                        .onDisappear { isTabBarHidden = false }
                                }
                            }
                        ) {
                            ZStack(alignment: .bottomLeading) {
                                Image(item.imageName)
                                    .resizable()
                                    .frame(width: 120, height: 150)
                                    .cornerRadius(10)
                                    .overlay(Color.black.opacity(0.2))
                                
                                Text(item.title)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                                    .shadow(radius: 8)
                                    .padding([.leading, .bottom], 10)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }

                    // Botón "Ver más"
                    if title != "Infografías" {
                        NavigationLink(destination: seeMoreDestination
                                        .onAppear { isTabBarHidden = true }
                                        .onDisappear { isTabBarHidden = false }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.customRed.opacity(0.6))
                                .frame(width: 120, height: 150)
                                .overlay(
                                    Text(seeMoreTitle)
                                        .foregroundColor(.white)
                                        .font(.title3)
                                        .bold()
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
