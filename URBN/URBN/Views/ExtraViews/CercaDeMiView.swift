//
//  CercaDeMiView.swift
//  URBN
//
//  Created by Ximena Cruz on 11/11/24.
//

import SwiftUI

struct CercaDeMiView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Este entorno te permitirá realizar la navegación de regreso
    @Environment(\.presentationMode) var presentationMode
    
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
                
                Text("Cerca de mi")
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
            .navigationBarBackButtonHidden(true) // Oculta la flecha de retroceso por defecto
            
            // Contenido en cuadrícula
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<6) { _ in
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 135)
                            
                            Text("Título")
                                .font(.headline)
                                .padding(.top, 8)
                                .padding(.horizontal)
                            
                            Text("Lorem Ipsum")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal, 24) // Aumentar margen izquierdo y derecho del grid
            }
        }
        .background(Color.white) // Fondo blanco
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CercaDeMiView()
}
