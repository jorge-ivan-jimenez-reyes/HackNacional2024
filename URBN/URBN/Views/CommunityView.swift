//
//  CommunityView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI

struct CommunityView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Barra de búsqueda y botones de acción
                HStack {
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

                    Button(action: {
                        // Acción para waveform
                    }) {
                        Image(systemName: "waveform")
                            .resizable()
                            .frame(width: 20, height: 25)
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }

                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 50, height: 50)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 3, y: 3)

                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .frame(width: 20, height: 25)
                            .foregroundColor(.red)
                    }

                    Spacer()
                }
                .padding(.top, 20)
                .padding(.horizontal)
                .background(Color.white)

                // Contenido en ScrollView
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Sección "Cerca de mí"
                        SectionView(
                            title: "Cerca de mí",
                            items: ["Lugar 1", "Lugar 2", "Lugar 3", "Lugar 4"],
                            seeMoreTitle: "Ver más",
                            seeMoreDestination: MoreItemsView(title: "Cerca de mí")
                        )

                        // Sección "Comunidades" con NavigationLink a SingleCommunityView
                        SectionView(
                            title: "Comunidades",
                            items: ["Comunidad 1", "Comunidad 2", "Comunidad 3", "Comunidad 4"],
                            seeMoreTitle: "Todas mis comunidades",
                            seeMoreDestination: MoreItemsView(title: "Todas mis comunidades"),
                            isCommunity: true
                        )

                        // Sección "Infografías"
                        SectionView(
                            title: "Infografías",
                            items: ["Infografía 1", "Infografía 2", "Infografía 3", "Infografía 4"],
                            seeMoreTitle: "Ver más",
                            seeMoreDestination: MoreItemsView(title: "Infografías")
                        )
                    }
                    .padding(.top, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SectionView<Destination: View>: View {
    var title: String
    var items: [String]
    var seeMoreTitle: String
    var seeMoreDestination: Destination
    var isCommunity: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(150))], spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        if isCommunity {
                            NavigationLink(destination: SingleCommunityView(communityName: item)) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 120, height: 150)
                                    .overlay(Text(item))
                            }
                        } else {
                            NavigationLink(destination: DetailView(item: item)) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 120, height: 150)
                                    .overlay(Text(item))
                            }
                        }
                    }

                    NavigationLink(destination: seeMoreDestination) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 120, height: 150)
                            .overlay(Text(seeMoreTitle))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// Vista de ejemplo para MoreItemsView
struct MoreItemsView: View {
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

// Vista de ejemplo para DetailView
struct DetailView: View {
    var item: String
    
    var body: some View {
        VStack {
            Text(item)
                .font(.title)
                .padding()
            Spacer()
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
