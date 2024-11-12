//
//  InfografiasView.swift
//  URBN
//
//  Created by Jorge Ivan Jimenez Reyes  on 12/11/24.
//

import SwiftUI

struct InfografiasView: View {
    @Environment(\.presentationMode) var presentationMode // Para regresar a la vista anterior
    var infografiaName: String // Nombre de la infografía seleccionada

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
                        .background(Color.gray.opacity(0.6)) // Fondo translúcido
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text(infografiaName)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    // Acción para configuración
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Contenido de la infografía
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "doc.text.image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 200)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Text("Título de la Infografía")
                    .font(.headline)
                    .padding(.top, 8)
                
                Text("Descripción breve de la infografía. Aquí puedes incluir información importante o hashtags relevantes.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)
                
                Button(action: {
                    // Acción para compartir la infografía
                }) {
                    Text("Compartir Infografía")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}

struct InfografiasView_Previews: PreviewProvider {
    static var previews: some View {
        InfografiasView(infografiaName: "Infografía Ejemplo")
    }
}
