//
//  NewsView.swift
//  URBN
//
//  Created by Jorge Ivan Jimenez Reyes  on 12/11/24.
//

//
//  NewsView.swift
//  URBN
//
//  Created by Ximena Cruz on 11/11/24.
//

import SwiftUI

struct NewsView: View {
    @Environment(\.presentationMode) var presentationMode
    var communityName: String
    
    var body: some View {
        VStack(spacing: 220) {
            ZStack {
                // Imagen de fondo personalizada según la comunidad
                Image(backgroundImage(for: communityName))
                    .resizable()
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all) // Que la imagen cubra toda la pantalla
                
                VStack(spacing: 0) {
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
                        
                        Text(communityName)
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        Button(action: {
                            // Acción para configuración
                        }) {
                            Image(systemName: "bookmark.fill")
                                .font(.title)
                                .foregroundColor(Color.red)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 50)
                    .padding()
                    .navigationBarBackButtonHidden(true)
                    
                    // Contenido de la comunidad
                    ScrollView {
                        VStack(spacing: 10) {
                            HStack(spacing: 10) {
                                PolaroidNewsCard(
                                    image: "Arresto",
                                    title: "Arrestan Personas",
                                    description: "Policías arrestan personas en calle enfrente de antro. #Cancún #Yucatán #Policía"
                                )
                                PolaroidNewsCard(
                                    image: "Fundacion",
                                    title: "Inauguran Fundación",
                                    description: "Así se vivió la fundación para recolectar víveres. #Mérida #Yucatán #Cenote #Yucatán2024 #México #Noticia"
                                )
                            }
                            
                            HStack(spacing: 10) {
                                PolaroidNewsCard(
                                    image: "Piramide",
                                    title: "Pirámide nueva",
                                    description: "Antropólogos descubren pirámide oculta en investigación. #Pirámide"
                                )
                                
                                PolaroidNewsCard(
                                    image: "Trafico",
                                    title: "Caos automovilístico",
                                    description: "El tráfico a todo lo que da. Toma tus precauciones. #Cancún #Sargazo #Turismo"
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 200)
                        .padding(.bottom, 50)
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    // Función que selecciona la imagen de fondo según el nombre de la comunidad
    private func backgroundImage(for communityName: String) -> String {
        switch communityName {
        case "Chiapas":
            return "Chiapas"
        case "CDMX":
            return "Cdmx" // Nombre de imagen para CDMX
        case "Sinaloa":
            return "Sinaloa" // Nombre de imagen para Sinaloa
        case "Campeche":
            return "Campeche" // Nombre de imagen para Campeche
        default:
            return "Chiapas" // Imagen predeterminada si no coincide
        }
    }
    
    struct PolaroidNewsCard: View {
        var image: String
        var title: String
        var description: String
        
        var body: some View {
            VStack(spacing: 0) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 175, height: 120)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .padding(.top, 8)
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 7)
            .frame(width: 175, height: 220)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(communityName: "Chiapas")
    }
}
