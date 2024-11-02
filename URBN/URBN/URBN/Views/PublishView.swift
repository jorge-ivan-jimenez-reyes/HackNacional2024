//
//  PublishView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI

struct PublishView: View {
    @State private var showingImagePicker = false
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle.fill")
    @State private var username: String = "asdfghjkhjgfds"
    @State private var postTitle: String = ""

    var body: some View {
        VStack {
            // Header con margen horizontal
            VStack {
                HStack {
                    profileImage?
                        .resizable()
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())
                        .onTapGesture {
                            showingImagePicker = true
                        }

                    VStack(alignment: .leading) {
                        Text("Bienvenido 👋")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)

                        TextField("Nombre de usuario", text: $username)
                            .font(.title)
                            .bold()
                            .textFieldStyle(PlainTextFieldStyle())
                    }

                    Spacer()

                    Button(action: {
                        // Acción del botón de configuración
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 3, y: 3)

                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.customRed)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .padding(.top, 20) // Espacio superior

            Spacer(minLength: 20)

            // Contenedor de imagen y título
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(height: 450)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 4)
                    .rotationEffect(.degrees(-12))

                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(height: 300)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )

                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.5))
                    }
                    .padding(.bottom, 20)
                    
                    TextField("Título", text: $postTitle)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                        .padding(.horizontal)
                }
                .padding()
                .rotationEffect(.degrees(-12))
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                // Acción para el botón de publicar
            }) {
                Text("Publicar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.customRed)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 30) // Espacio inferior para evitar que se amontone con el tab bar
        }
        .sheet(isPresented: $showingImagePicker) {
            // Selector de imagen
        }
    }
}

#Preview {
    PublishView()
}
