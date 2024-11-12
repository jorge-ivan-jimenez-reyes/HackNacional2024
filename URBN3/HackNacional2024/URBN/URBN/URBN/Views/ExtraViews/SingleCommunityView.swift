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
                    Image(systemName: "gearshape.fill")
                        .font(.title)
                        .foregroundColor(.customRed) // Puedes personalizar el color aquí
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Posts tipo Polaroid apilados
            ZStack {
                ForEach((0..<3).reversed(), id: \.self) { index in
                    PolaroidPostView()
                        .rotationEffect(.degrees(index == 0 ? 0 : Double(index) * 5))
                        .offset(x: CGFloat(index) * 10, y: CGFloat(index) * 10)
                }
            }
            .padding(.bottom, 30)
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}

// Vista de cada post tipo Polaroid
struct PolaroidPostView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Imagen predeterminada
            Image(systemName: "photo")
                .resizable()
                .frame(width: 320, height: 340) // Tamaño más grande
                .clipped()
                .padding(10) // Borde alrededor de la imagen
            
            // Título y Descripción
            VStack(alignment: .leading, spacing: 4) {
                Text("Cenote Nuevo")
                    .font(.headline)
                    .padding(.top, 8)
                
                Text("Encuentran un nuevo cenote en una casa en Mérida. #Merida #Yucatán #Cenote #Yucatán2024 #México #Noticia")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 1)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 360, height: 500) // Tamaño más grande
        .background(Color.white)
        .border(Color.gray.opacity(0.3), width: 1)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
    }
}

struct SingleCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCommunityView(communityName: "CDMX")
    }
}
