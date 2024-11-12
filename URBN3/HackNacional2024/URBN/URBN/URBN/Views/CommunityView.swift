import SwiftUI
import AVKit

// Estructura para representar una infografía con un nombre y una imagen
struct InfografiaItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct CommunityView: View {
    @State private var searchText: String = ""
    
    // Lista de infografías con nombres e imágenes
    let infografias = [
        InfografiaItem(name: "Incendios", imageName: "incendios"),
        InfografiaItem(name: "Sismos", imageName: "sismos"),
        InfografiaItem(name: "Robos", imageName: "robos"),
        InfografiaItem(name: "Inundaciones", imageName: "inundaciones")
    ]
    
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

                        // Sección "Infografías" con NavigationLink a DetailedInfografiaView
                        InfografiaSectionView(
                            title: "Infografías",
                            infografias: infografias,
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

// Vista para la sección de infografías personalizada con video solo en "Incendios"
struct InfografiaSectionView<Destination: View>: View {
    var title: String
    var infografias: [InfografiaItem]
    var seeMoreTitle: String
    var seeMoreDestination: Destination

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(150))], spacing: 16) {
                    ForEach(infografias) { infografia in
                        NavigationLink(destination: DetailedInfografiaView(infografiaName: infografia.name)) {
                            VStack {
                                if infografia.name == "Incendios" {
                                    // Usa VideoPlayer solo para "Incendios"
                                    VideoPlayerView(videoName: "bonfire-particles")
                                        .frame(width: 120, height: 150)
                                        .cornerRadius(10)
                                } else {
                                    // Fondo estándar que ocupa todo el espacio
                                    ZStack {
                                        Image(infografia.imageName)
                                            .resizable()
                                            .scaledToFill() // Abarca todo el espacio
                                            .frame(width: 120, height: 150)
                                            .clipped() // Recorta la imagen si es necesario
                                            .cornerRadius(10)
                                        Text(infografia.name)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .background(Color.black.opacity(0.6))
                                            .padding(5)
                                            .cornerRadius(5)
                                    }
                                }
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

// Subvista para reproducir video
struct VideoPlayerView: View {
    let videoName: String
    
    var body: some View {
        if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            VideoPlayer(player: AVPlayer(url: url))
                .onAppear {
                    AVPlayer(url: url).play() // Inicia el video automáticamente
                }
        } else {
            Text("Video no encontrado")
                .foregroundColor(.red)
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

// Vista de ejemplo para InfografiasView renombrada
struct DetailedInfografiaView: View {
    var infografiaName: String
    
    var body: some View {
        VStack {
            Text(infografiaName)
                .font(.largeTitle)
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
