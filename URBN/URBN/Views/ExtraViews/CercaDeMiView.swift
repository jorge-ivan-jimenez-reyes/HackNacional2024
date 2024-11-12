//
//  CercaDeMiView.swift
//  URBN
//
//  Created by Ximena Cruz on 11/11/24.
//

import SwiftUI

// Datos para cada cuadro en la vista CercaDeMiView
struct NearbyItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String
}

struct CercaDeMiView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isTabBarHidden: Bool  // Binding para controlar la visibilidad del TabBar

    // Arreglo de datos de ejemplo
    let nearbyItems: [NearbyItem] = [
        NearbyItem(title: "Sismo en Mixcoac", imageName: "Mixcoac", description: "Las falla de Mixcoac ataca otra vez."),
        NearbyItem(title: "Choque en Eje 8 Sur", imageName: "Choque", description: "Deja 5 lesionados."),
        NearbyItem(title: "Carambola en Augusto Rodin", imageName: "Carambola", description: "Conductores desesperados sufren las consecuencias."),
        NearbyItem(title: "Manifestantes cierran calle", imageName: "Manifestantes", description: "Con el fin de pedir justicia para su causa."),
        NearbyItem(title: "Calle en reparación", imageName: "Calle", description: "Toma tus precauciones al pasar por esta calle."),
        NearbyItem(title: "Evento religioso", imageName: "Evento", description: "Peregrinos ocupan ejes viales enteros.")
    ]
    
    var body: some View {
        VStack {
            // Encabezado
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.gray.opacity(0.6))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text("Cerca de mí")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    // Acción para configuración
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title)
                        .foregroundColor(.customRed)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
            }
            .padding(.horizontal, 24)
            .navigationBarBackButtonHidden(true)
            
            // Contenido en cuadrícula
            ScrollView {
                LazyVGrid(columns: columns, spacing: 19) {
                    ForEach(nearbyItems) { item in
                        VStack(alignment: .leading) {
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill) // Llenar el contenedor aunque se recorte
                                .frame(height: 100)
                                .clipped()
                            
                            Text(item.title)
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(3)               // Truncar descripción si es demasiado larga
                                .truncationMode(.tail)
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                        }
                        .frame(height: 200)               // Altura fija para todas las tarjetas
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear { isTabBarHidden = true }
        .onDisappear { isTabBarHidden = false }
    }
}

#Preview {
    CercaDeMiView(isTabBarHidden: .constant(false))
}
