import SwiftUI

struct EmergencyContact: Identifiable {
    var id = UUID()
    var name: String
    var profileImage: Image? = Image(systemName: "person.crop.circle.fill")
}

struct SOSView: View {
    @State private var contacts: [EmergencyContact] = [
        EmergencyContact(name: "Nombre 1", profileImage: Image("profile1")),
        EmergencyContact(name: "Nombre 2", profileImage: Image("profile2")),
        EmergencyContact(name: "Nombre 3", profileImage: Image("profile3"))
    ]
    @State private var showingAlert = false
    @State private var showingChatBotView = false // Estado para controlar la presentación del chatbot

    var body: some View {
        VStack(spacing: 20) {
            // Header con el nombre de la app y un icono
            HStack {
                Image(systemName: "newspaper.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.red)
                
                Text("Newsip")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                
                Spacer()
                
                // Botón para abrir el chatbot
                Button(action: {
                    showingChatBotView = true
                }) {
                    Image(systemName: "message.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.red)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .sheet(isPresented: $showingChatBotView) {
                    ChatBotView() // Muestra ChatBotView como una hoja modal
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)

            // Contactos
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(contacts) { contact in
                        VStack(spacing: 8) {
                            contact.profileImage?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .shadow(radius: 5)

                            Text(contact.name)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }

                    // Botón para agregar un nuevo contacto
                    Button(action: {
                        contacts.append(EmergencyContact(name: "Nuevo Contacto"))
                    }) {
                        VStack(spacing: 8) {
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                                    .shadow(radius: 5)
                            }
                            Text("Agregar")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 10)

            Spacer()

            // Botón SOS
            VStack(spacing: 12) {
                Button(action: {
                    sendSOSMessage()
                }) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.red]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)

                        Image(systemName: "dot.radiowaves.left.and.right")
                            .resizable()
                            .frame(width: 90, height: 70)
                            .foregroundColor(.white)
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("SOS Enviado"),
                        message: Text("Tu mensaje SOS ha sido enviado a \(contacts.count) contactos."),
                        dismissButton: .default(Text("Aceptar"))
                    )
                }

                Text("Presiona el botón para enviar un mensaje de emergencia")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }

    func sendSOSMessage() {
        showingAlert = true
    }
}
