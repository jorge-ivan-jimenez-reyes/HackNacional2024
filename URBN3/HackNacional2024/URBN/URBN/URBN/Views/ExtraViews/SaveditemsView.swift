//
//  Untitled.swift
//  URBN
//
//  Created by Jorge Ivan Jimenez Reyes  on 12/11/24.
//

//
//  SavedItemsView.swift
//  URBN
//
//  Created by Ximena Cruz on 12/11/24.
//


import SwiftUI

struct SavedItemsView: View {
    @Environment(\.presentationMode) var presentationMode

    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
        let description: String?
    }

    // Ejemplo de items guardados
    let savedItems: [Item] = [
        Item(title: "Sismo en Mixcoac", imageName: "Mixcoac", description: "Las falla de Mixcoac ataca otra vez."),
        Item(title: "Pirámide nueva", imageName: "Piramide",
            description: "Antropólogos descubren pirámide oculta en investigación. #Pirámide"
         )
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
                
                Text("Elementos guardados")
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
            .padding()
            .background(Color.customRed)
            .foregroundColor(.white)
            
            // Lista de elementos guardados
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(savedItems) { item in
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                Text(item.description ?? "Descripción no disponible")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                                .padding(.trailing)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 2, y: 2)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}

struct SavedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedItemsView()
    }
}
