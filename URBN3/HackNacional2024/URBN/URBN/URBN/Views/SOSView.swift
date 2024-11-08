//
//  SOSView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI
struct Contact: Identifiable {
    var id = UUID()
    var name: String
}

struct SOSView: View {
    @State private var contacts: [Contact] = [Contact(name: "Nombre 1"), Contact(name: "Nombre 2"), Contact(name: "Nombre 3")]
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle.fill") // Placeholder de imagen
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var username: String = "Usuario" // Nombre de usuario editable

    var body: some View {
        VStack {
            // Header con imagen y nombre de usuario
            HStack {
                profileImage?
                    .resizable()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.gray)
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
            .padding()

            // Placeholder para contactos (dinámico)
            HStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(contacts) { contact in
                            VStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                Text(contact.name)
                                    .font(.caption)
                            }
                        }

                        VStack {
                            Button(action: {
                                contacts.append(Contact(name: "Nuevo Contacto"))
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.customRed)
                                        .frame(width: 80, height: 80)
                                    HStack(spacing: 6) {
                                        ForEach(0..<3) { _ in
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                                }
                            }
                            Text("Editar")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding()

            Spacer()

            VStack {
                Button(action: {
                }) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.145, blue: 0.145), Color(red: 1, green: 0.75, blue: 0.75)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(width: 200, height: 200)

                        Circle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.75, blue: 0.75), Color(red: 1, green: 0.145, blue: 0.145)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(width: 160, height: 160)

                        Image(systemName: "dot.radiowaves.left.and.right")
                            .resizable()
                            .frame(width: 100, height: 80)
                            .foregroundColor(.white)
                    }
                }

                Text("Da click o deja presionado para un audio")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 10)

                HStack(spacing: -10) {
                    ForEach(contacts.indices, id: \.self) { _ in
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.top, 10)

                Text("Tu SOS se mandará a \(contacts.count) personas")
                    .font(.footnote)
                    .foregroundColor(.black)
                    .padding(.top, 10)
            }

            Spacer()

        }
        .padding(.horizontal)
        }
    }




// Preview
#Preview {
    SOSView()
}
