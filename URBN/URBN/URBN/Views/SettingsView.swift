//
//  SettingsView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    @State private var profileImage: Image? = Image("default_profile_picture") // Imagen por defecto
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var username: String = "Tibiales Johnson" // Nombre de usuario por defecto
    
    var body: some View {
        NavigationView {
            VStack {
                // Imagen de perfil centrada hasta arriba
                VStack {
                    ZStack {
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
                                .frame(width: 150, height: 150)
                                .foregroundColor(.gray)
                        }
                        
                        // Botón de cámara sobre la imagen de perfil
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    showingImagePicker = true
                                }) {
                                    Image(systemName: "camera.circle.fill")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: 40, height: 40)
                                        .background(Circle().fill(Color.white))
                                        .offset(x: -115, y: -60)
                                }
                            }
                        }
                    }
                    .padding()
                }
                
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
                
                Spacer()
            }
            .navigationBarTitle("Perfil", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                // Acción del botón atrás
            }) {
                Image(systemName: "chevron.left.circle.fill")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                    .font(.system(size: 28))
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) { // AQUÍ VA LA LÍNEA CORRECTA
                CustomImagePicker(image: $inputImage) // Usamos el nuevo nombre aquí
            }
        }
    }
    
    // Función para cargar la imagen seleccionada
    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}


struct CustomImagePicker: UIViewControllerRepresentable { // Cambié el nombre aquí
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CustomImagePicker

        init(parent: CustomImagePicker) { // Actualizamos aquí
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false // Cambia a true si quieres permitir la edición
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


#Preview {
    SettingsView()
}
