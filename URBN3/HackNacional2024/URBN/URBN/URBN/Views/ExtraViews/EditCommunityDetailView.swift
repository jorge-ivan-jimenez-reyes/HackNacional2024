//
//  EditCommunityDetailView.swift
//  URBN
//
//  Created by Jorge Ivan Jimenez Reyes  on 12/11/24.
//

import SwiftUI

struct EditCommunityDetailView: View {
    @State private var communityName: String // Nombre de la comunidad editada
    var onSave: (String) -> Void // Callback para guardar los cambios
    
    init(communityName: String, onSave: @escaping (String) -> Void) {
        _communityName = State(initialValue: communityName)
        self.onSave = onSave
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Editar \(communityName)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            TextField("Nombre de la comunidad", text: $communityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()

            Button(action: {
                onSave(communityName) // Llama la función de guardado
            }) {
                Text("Guardar cambios")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Editar Comunidad")
    }
}

struct EditCommunityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditCommunityDetailView(communityName: "Comunidad 1", onSave: { _ in })
    }
}
