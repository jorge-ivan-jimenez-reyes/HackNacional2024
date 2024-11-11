//
//  CommunityView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Buscar", text: .constant(""))
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

                    // Botón de configuración al lado de la barra de búsqueda
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 50, height: 50)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 3, y: 3)

                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .frame(width: 20, height: 25)
                            .foregroundColor(.customRed) // Usando customRed
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
                            seeMoreDestination: CercaDeMiView()
                        )

                        // Sección "Comunidades"
                        SectionView(
                            title: "Comunidades",
                            items: ["Comunidad 1", "Comunidad 2", "Comunidad 3", "Comunidad 4"],
                            seeMoreTitle: "Todas mis comunidades",
                            seeMoreDestination: MoreItemsView(title: "Todas mis comunidades")
                        )

                        // Sección "Infografías"
                        SectionView(
                            title: "Infografías",
                            items: ["Infografía 1", "Infografía 2", "Infografía 3", "Infografía 4"],
                            seeMoreTitle: "Ver más",
                            seeMoreDestination: MoreItemsView(title: "Ver más")
                        )
                    }
                    .padding(.top, 20)
                }
            }
            .navigationBarHidden(true) // Oculta la barra de navegación por defecto
        }
    }
}

struct SectionView<Destination: View>: View {
    var title: String
    var items: [String]
    var seeMoreTitle: String
    var seeMoreDestination: Destination

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(150))], spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: DetailView(item: item)) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 120, height: 150)
                                .overlay(Text(item))
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

struct DetailView: View {
    var item: String

    var body: some View {
        Text("Detalles de \(item)")
            .navigationTitle(item)
    }
}

struct MoreItemsView: View {
    var title: String

    var body: some View {
        Text("Más sobre \(title)")
            .navigationTitle(title)
    }
}

#Preview {
    CommunityView()
}
