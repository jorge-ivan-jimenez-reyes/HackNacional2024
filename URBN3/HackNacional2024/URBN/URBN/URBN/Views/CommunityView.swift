//
//  CommunityView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//


import SwiftUI


struct CommunityView: View {
    @Binding var isTabBarHidden: Bool
    @State private var searchText: String = ""
    
    @State private var isInfografiaViewActive: Bool = false
    @State private var selectedInfografia: String? = nil


    let communityItems: [Item] = [
        Item(title: "Chiapas", imageName: "Chiapas"),
        Item(title: "CDMX", imageName: "Cdmx"),
        Item(title: "Sinaloa", imageName: "Sinaloa"),
        Item(title: "Campeche", imageName: "Campeche")
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Barra de búsqueda y botones de acción
                HStack {
                    // Barra de búsqueda con icono de lupa
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Buscar", text: $searchText)
                            .frame(height: 40)
                            .padding(.leading, 5)
                    }
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                    // Botón de waveform
                    Button(action: {
                        // Acción para waveform
                    }) {
                        Image(systemName: "waveform")
                            .resizable()
                            .frame(width: 20, height: 25)
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }

                    // Ícono de bookmark con fondo circular
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 50, height: 50)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 3, y: 3)

                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .frame(width: 20, height: 25)
                            .foregroundColor(.customRed)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal)
                .background(Color.white)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        SectionView(
                            title: "Cerca de mí",
                            items: [
                                Item(title: "Centro \nhistórico", imageName: "Centro"),
                                Item(title: "Benito \nJuárez", imageName: "BJ"),
                                Item(title: "Coyoacán", imageName: "Coyoacan"),
                                Item(title: "Miguel \nHidalgo", imageName: "MH")
                            ],
                            seeMoreTitle: "Ver más",
                            seeMoreDestination: CercaDeMiView(isTabBarHidden: $isTabBarHidden),
                            isCommunity: false,
                            isTabBarHidden: $isTabBarHidden
                        )

                        SectionView(
                            title: "Comunidades",
                            items: communityItems,
                            seeMoreTitle: "Todas mis comunidades",
                            seeMoreDestination: MoreItemsView(title: "Todas mis comunidades", isTabBarHidden: $isTabBarHidden),
                            isCommunity: true,
                            isTabBarHidden: $isTabBarHidden
                        )

                        SectionView(
                            title: "Infografías",
                            items: [
                                Item(title: "Sismo", imageName: "sismo"),
                                Item(title: "Incendio", imageName: "Incendio"),
                                Item(title: "Calor \nextremo", imageName: "Calor extremo"),
                                Item(title: "Inundación", imageName: "Inundación"),
                                Item(title: "Sequías", imageName: "Sequias"),
                                Item(title: "Tornado", imageName: "Tornado")
                            ],
                            seeMoreTitle: "Más infografías",
                            seeMoreDestination: MoreItemsView(title: "Más infografías", isTabBarHidden: $isTabBarHidden),
                            isCommunity: false,
                            isTabBarHidden: $isTabBarHidden
                        )
                        .onTapGesture {
                            selectedInfografia = "Sismo"
                            isInfografiaViewActive = true
                        }

                    }
                    .padding(.top, 20)
                }
            }
            .navigationBarHidden(true)
            .onAppear { isTabBarHidden = false }
        }
    }
}


// Define MoreItemsView dentro del mismo archivo
struct MoreItemsView: View {
    var title: String
    @Binding var isTabBarHidden: Bool

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .onAppear { isTabBarHidden = true }
        .onDisappear { isTabBarHidden = false }
    }
}


struct CommunityView_Previews: PreviewProvider {
    @State static var isTabBarHidden = false
    
    static var previews: some View {
        CommunityView(isTabBarHidden: $isTabBarHidden)
    }
}
