//
//  SettingsView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

//
//  SettingsView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI
import PhotosUI
import UIKit

struct SettingsView: View {
    @State private var profileImage: Image? // La imagen de perfil que se seleccionará
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var username: String = "Usuario" // Nombre de usuario por defecto
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) { // Espacio vertical entre los elementos
                Spacer() // Empuja los elementos hacia el centro verticalmente
                
                // Imagen de perfil centrada hasta arriba con acción para desplegar ImagePicker
                VStack {
                    ZStack {
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.gray) // Imagen por defecto en gris
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            }
                        }
                    }
                }
                .padding(.bottom, 20) // Espacio debajo de la imagen de perfil
                
                // Campo de texto para personalizar el nombre de usuario
                TextField("Nombre de Usuario", text: $username)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                // Opciones de perfil
                Form {
                    Section {
                        NavigationLink(destination: Text("Política de Privacidad")) {
                            HStack {
                                Image(systemName: "shield")
                                    .foregroundColor(.red)
                                    .imageScale(.large)
                                Text("Política de Privacidad")
                                    .font(.system(size: 20))
                            }
                        }
                        
                        NavigationLink(destination: Text("Términos y Condiciones")) {
                            HStack {
                                Image(systemName: "doc.text")
                                    .foregroundColor(.red)
                                    .imageScale(.large)
                                Text("Términos y Condiciones")
                                    .font(.system(size: 20))
                            }
                        }
                        
                        NavigationLink(destination: Text("Contactar Soporte")) {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.red)
                                    .imageScale(.large)
                                Text("Contactar Soporte")
                                    .font(.system(size: 20))
                            }
                        }
                        
                        NavigationLink(destination: Text("Reportar Bug")) {
                            HStack {
                                Image(systemName: "exclamationmark.circle")
                                    .foregroundColor(.red)
                                    .imageScale(.large)
                                Text("Reportar Bug")
                                    .font(.system(size: 20))
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(maxWidth: .infinity, maxHeight: 300) // Ajusta el tamaño del formulario
                
                Spacer() // Agrega espacio al final para centrar verticalmente
            }
            .padding(.horizontal, 20) // Espaciado horizontal para todos los elementos
            .navigationBarTitle("Perfil", displayMode: .inline)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    // Función para cargar la imagen seleccionada
    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary // Abre el selector de fotos
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    SettingsView()
}
