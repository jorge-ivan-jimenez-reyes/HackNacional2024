//
//  SingleCommunityView.swift
//  URBN
//
//  Created by Ximena Cruz on 11/11/24.
//


import SwiftUI

struct SingleCommunityView: View {
    @Environment(\.presentationMode) var presentationMode // Para regresar a la vista anterior
    var communityName: String // Nombre de la comunidad seleccionada

    var body: some View {
        VStack {
            // Encabezado
            HStack {
                Button(action: {
                    // Acción para regresar a CommunityView
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.gray.opacity(0.6)) // Fondo translúcido
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text(communityName)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    // Acción para configuración
                }) {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .frame(width: 20, height: 25)
                        .foregroundColor(.customRed)
                        .padding(13)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                    
                }
            }
            .padding(.horizontal,20)
            .padding(.top)
            
            Spacer()
            
            // Contenedor de tarjetas deslizables
                       SwipeableView(posts: samplePosts)
                           .padding(.bottom, 30)
                       
                       Spacer()
                   }
                   .background(Color.white.edgesIgnoringSafeArea(.all))
                   .navigationBarBackButtonHidden(true)
               }
           }

           // Modelo para representar publicaciones
struct Post: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

// Muestra de datos
let samplePosts: [Post] = [
    Post(imageName: "LicenciaConducir", title: "Licencia de Conducir Permanente", description: "La Ciudad de México reintroduce la licencia de conducir permanente. Disponible desde el 16 de noviembre por 1,500 pesos."),
    Post(imageName: "AtaqueBar", title: "Ataque en Bar de Querétaro", description: "Ataque armado en un bar de Querétaro deja 10 muertos y 13 heridos. Un sospechoso fue detenido."),
    Post(imageName: "MetroCongestion", title: "Congestión en el Metro", description: "Líneas 7 y 12 del Metro presentan alta afluencia y retrasos. Se recomienda planificar viajes con anticipación."),
    Post(imageName: "FabianPacheco", title: "Reaparición de Fabián Pacheco", description: "El cantante Fabián Pacheco fue encontrado en un hotel de la CDMX tras varios días de búsqueda."),
    Post(imageName: "COP29", title: "Participación en la COP29", description: "México participará en la COP29 en Bakú, Azerbaiyán, para fortalecer la acción climática global."),
    Post(imageName: "TrenSuburbano", title: "Bloqueo en Tren Suburbano", description: "Vecinos de Tultepec mantienen bloqueadas las obras del Tren Suburbano, exigiendo obras colaterales."),
    Post(imageName: "MuseoAntropologia", title: "Mayor Asistencia en el Museo", description: "El Museo Nacional de Antropología registra más de tres millones de visitas en el año, un récord desde 2019.")
]
           // Vista de tarjetas deslizables
struct SwipeableView: View {
    @State private var posts: [Post]
    @State private var offset: CGSize = .zero
    @State private var currentIndex = 0

    // Inicializador público para aceptar los datos de las tarjetas
    init(posts: [Post]) {
        self._posts = State(initialValue: posts)
    }

    var body: some View {
        ZStack {
            ForEach(posts.indices.reversed(), id: \.self) { index in
                CardView(post: posts[index])
                    .offset(index == currentIndex ? offset : .zero)
                    .scaleEffect(index == currentIndex ? 1.0 : 0.9)
                    .rotationEffect(.degrees(index == currentIndex ? Double(offset.width / 10) : 0))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if index == currentIndex {
                                    offset = gesture.translation
                                }
                            }
                            .onEnded { _ in
                                if abs(offset.width) > 100 {
                                    removeCard(at: index)
                                } else {
                                    offset = .zero
                                }
                            }
                    )
                    .animation(.spring(), value: offset)
            }
        }
    }

    func removeCard(at index: Int) {
        withAnimation {
            offset = CGSize(width: offset.width > 0 ? 500 : -500, height: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                posts.remove(at: index)
                offset = .zero
                if currentIndex >= posts.count {
                    currentIndex = posts.count - 1
                }
            }
        }
    }
}


           // Vista de la tarjeta individual
           struct CardView: View {
               let post: Post

               var body: some View {
                   VStack(spacing: 0) {
                       // Imagen
                       Image(post.imageName)
                           .resizable()
                           .scaledToFill()
                           .frame(width: 320, height: 340)
                           .clipped()

                       // Título y Descripción
                       VStack(alignment: .leading, spacing: 4) {
                           Text(post.title)
                               .font(.headline)
                               .padding(.top, 8)
                           Text(post.description)
                               .font(.subheadline)
                               .foregroundColor(.secondary)
                               .padding(.bottom, 8)
                       }
                       .padding(.horizontal)
                       .frame(maxWidth: .infinity, alignment: .leading)
                   }
                   .frame(width: 360, height: 500)
                   .background(Color.white)
                   .cornerRadius(12)
                   .shadow(radius: 5)
               }
           }

           // Vista previa
           struct SingleCommunityView_Previews: PreviewProvider {
               static var previews: some View {
                   SingleCommunityView(communityName: "CDMX")
               }
           }
