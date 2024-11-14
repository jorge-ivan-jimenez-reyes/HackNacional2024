//
//  PublishView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI

struct PublishView: View {
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle.fill")
    @State private var username: String = "Usuario"
    @State private var postTitle: String = "Título de ejemplo"
    @State private var incidentDescription: String = "Descripción del incidente con #hashtagEjemplo"
    @State private var hashtags: [String] = []
    @State private var dynamicHeight: CGFloat = 40 // Altura inicial del TextEditor

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Header
                VStack(spacing: 10) {
                    HStack(spacing: 15) {
                        profileImage?
                            .resizable()
                            .frame(width: 65, height: 65)
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                            .onTapGesture {
                                // Acción para cambiar la imagen de perfil
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Bienvenido 👋")
                                .font(.headline)
                                .foregroundColor(.secondary)

                            TextField("Nombre de usuario", text: $username)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                                .textFieldStyle(PlainTextFieldStyle())
                        }

                        Spacer()

                        Button(action: {
                            // Acción del botón de configuración
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 45, height: 45)
                                    .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 2)

                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 20)

                // Contenedor de imagen, título y descripción
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)

                    VStack(spacing: 15) {
                        // Placeholder de imagen
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(height: 250)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )

                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.gray.opacity(0.4))
                        }
                        .padding(.horizontal, 20)

                        // Título del post
                        TextField("Título del incidente", text: $postTitle)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .font(.body)

                        // Descripción del incidente
                        DynamicHeightTextEditor(text: $incidentDescription, height: $dynamicHeight)
                            .frame(height: dynamicHeight)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .onChange(of: incidentDescription) { newText in
                                detectHashtags(in: newText)
                            }

                        // Hashtags detectados
                        if !hashtags.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(hashtags, id: \.self) { hashtag in
                                        Text("#\(hashtag)")
                                            .font(.subheadline)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 12)
                                            .background(Color.blue.opacity(0.1))
                                            .cornerRadius(12)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)

                // Botón Publicar
                Button(action: {
                    // Acción para el botón de publicar
                    publishIncident()
                }) {
                    Text("Publicar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 30)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }

    // Función para detectar hashtags en la descripción
    private func detectHashtags(in text: String) {
        let words = text.split(separator: " ")
        hashtags = words.filter { $0.hasPrefix("#") }.map { String($0.dropFirst()) }
    }

    // Función para publicar el incidente (solo para fines de ejemplo)
    private func publishIncident() {
        print("Publicando incidente con título: \(postTitle), descripción: \(incidentDescription) y hashtags: \(hashtags)")
        // Aquí se podría agregar lógica adicional si se necesitara
    }
}

// Componente para ajustar el TextEditor dinámicamente
struct DynamicHeightTextEditor: View {
    @Binding var text: String
    @Binding var height: CGFloat

    var body: some View {
        TextEditor(text: $text)
            .background(
                Text(text)
                    .font(.body)
                    .padding()
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                height = geometry.size.height
                            }
                            .onChange(of: text) { _ in
                                height = geometry.size.height
                            }
                    })
                    .opacity(0) // Oculto, solo para medir altura
            )
    }
}

#Preview {
    PublishView()
}
