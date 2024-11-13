import SwiftUI

struct EditCommunityView: View {
    @Binding var communities: [String] // Lista de comunidades editable

    var body: some View {
        VStack(alignment: .leading) {
            Text("Editar Comunidades")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            List {
                ForEach(communities.indices, id: \.self) { index in
                    HStack {
                        TextField("Nombre de la comunidad", text: $communities[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            Spacer()
            
            Button(action: {
                // Agregar una nueva comunidad
                communities.append("Nueva Comunidad")
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Agregar Comunidad")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .padding()
        }
        .padding(.top)
        .navigationTitle("Editar Comunidades")
    }
}

struct EditCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        EditCommunityView(communities: .constant(["Comunidad 1", "Comunidad 2", "Comunidad 3"]))
    }
}
