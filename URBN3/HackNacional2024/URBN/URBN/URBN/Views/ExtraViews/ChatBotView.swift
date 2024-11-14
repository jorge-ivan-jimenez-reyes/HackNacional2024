import SwiftUI
import MapKit

struct ChatBotView: View {
    @State private var messages: [String] = ["Bot: Hola, ¿en qué puedo ayudarte?"]
    @State private var newMessage: String = ""
    @State private var showMap = false // Controla la navegación al mapa

    var body: some View {
        VStack {
            // Encabezado del chat
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                    .font(.title2)
                Text("Chat de Emergencia")
                    .font(.title)
                    .bold()
                    .foregroundColor(.red)
            }
            .padding(.vertical)
            
            Divider()
                .padding(.horizontal)

            // Lista de mensajes del chat
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(messages, id: \.self) { message in
                        HStack(alignment: .top, spacing: 10) {
                            if message.starts(with: "Bot:") {
                                Image(systemName: "person.fill.questionmark")
                                    .foregroundColor(.red)
                                    .padding(5)
                                    .background(Color.red.opacity(0.2))
                                    .clipShape(Circle())
                                Text(message.replacingOccurrences(of: "Bot: ", with: ""))
                                    .padding()
                                    .background(Color.red.opacity(0.1))
                                    .cornerRadius(10)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Spacer()
                                Text(message.replacingOccurrences(of: "Tú: ", with: ""))
                                    .padding()
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(.blue)
                                    .padding(5)
                                    .background(Color.blue.opacity(0.2))
                                    .clipShape(Circle())
                            }
                        }
                        .transition(.move(edge: .bottom))
                    }
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding()

            // Sugerencias rápidas
            HStack {
                Text("Sugerencias Rápidas:")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal)

            HStack(spacing: 15) {
                ForEach(["Sismo", "Incendio", "Accidente", "Inundación", "Zona segura"], id: \.self) { suggestion in
                    Button(action: {
                        newMessage = suggestion
                        sendMessage()
                    }) {
                        Text(suggestion)
                            .padding()
                            .background(Color.red.opacity(0.15))
                            .foregroundColor(.red)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                }
            }
            .padding(.horizontal)

            // Campo de entrada de texto para mensajes
            HStack {
                TextField("Escribe un mensaje...", text: $newMessage)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .padding(.leading, 5)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .navigationTitle("Chatbot de Emergencia")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showMap) {
            SafeZonesMapView()
        }
    }

    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        withAnimation {
            messages.append("Tú: \(newMessage)")
            let response = getBotResponse(to: newMessage)
            messages.append("Bot: \(response)")
            newMessage = ""
        }
    }

    // Genera respuestas automáticas del bot
    func getBotResponse(to message: String) -> String {
            let lowercasedMessage = message.lowercased()
            
            if lowercasedMessage.contains("zona segura") || lowercasedMessage.contains("refugio") {
                showMap = true
                return "Te mostraré las zonas seguras cercanas en el mapa."
            } else if lowercasedMessage.contains("sismo") {
                return """
                En caso de sismo:
                1. Agáchate, cúbrete y sujétate.
                2. Evita salir corriendo.
                3. Aléjate de ventanas y objetos que puedan caer.
                4. Después del sismo, evalúa daños antes de salir.
                """
        } else if lowercasedMessage.contains("incendio") {
            return """
            En caso de incendio:
            1. Mantén la calma y evalúa la situación.
            2. Si hay humo, gatea cerca del suelo.
            3. Usa una toalla húmeda para cubrir tu nariz y boca.
            4. Evita el uso de elevadores.
            """
        }
        else if lowercasedMessage.contains("envenenamiento") {
            return """
            En caso de envenenamiento:
            1. Llama al 911 y describe el tipo de veneno, si es posible.
            2. No provoques el vómito a menos que un profesional lo indique.
            3. Si la persona está consciente, dale pequeños sorbos de agua para diluir la sustancia.
            4. Mantén la calma y sigue las indicaciones de emergencia hasta que llegue ayuda.
            """
        }

        else if lowercasedMessage.contains("huracán") {
            return """
            En caso de huracán:
            1. Refúgiate en una habitación sin ventanas o en el centro de la casa.
            2. Reúne agua potable, alimentos no perecederos y una linterna.
            3. Mantente actualizado a través de la radio o la televisión y sigue las recomendaciones de las autoridades.
            4. Evita salir hasta que las autoridades confirmen que el huracán ha pasado y es seguro.
            """
        }
        else if lowercasedMessage.contains("golpe de calor") {
            return """
            En caso de golpe de calor:
            1. Lleva a la persona a un lugar fresco y a la sombra.
            2. Enfría su cuerpo con agua y abanica para bajar la temperatura corporal.
            3. Dale agua a sorbos pequeños si está consciente.
            4. Busca ayuda médica de inmediato si la persona no mejora o pierde la conciencia.
            """
        }

        
        else if lowercasedMessage.contains("accidente") {
            return """
            En caso de accidente:
            1. Llama al 911.
            2. Asegura la zona para evitar otros accidentes.
            3. Si sabes primeros auxilios, ofrece ayuda.
            4. Mantén a los heridos seguros hasta que llegue ayuda.
            """
        } else if lowercasedMessage.contains("emergencia") {
            return """
            Consejos generales para emergencias:
            1. Ten un plan de escape y punto de reunión.
            2. Lleva un botiquín y contactos de emergencia.
            3. Aprende primeros auxilios básicos.
            4. Mantén la calma y sigue instrucciones de las autoridades.
            """
            
            
        }
        
          // Agrega el resto de los casos de emergencia aquí como bloques `else if`
        else if lowercasedMessage.contains("inundación") {
            return """
            En caso de inundación:
            1. Busca un lugar alto y seguro, alejado de corrientes de agua.
            2. Evita caminar o conducir en áreas inundadas; solo 15 cm de agua pueden hacerte caer.
            3. Desconecta el suministro de electricidad y cierra las llaves de agua y gas para evitar accidentes.
            4. Mantente informado a través de fuentes oficiales y espera instrucciones de evacuación si es necesario.
            """
        }
        else {
            return "Lo siento, no tengo una respuesta para eso. Intenta preguntar sobre 'sismo', 'incendio', 'accidente' o 'emergencia'."
        }
    }
}

// Preview para visualizar el ChatBotView
struct ChatBotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBotView()
    }
}
struct SafeZonesMapView: View {
    var body: some View {
        TripMapView(
            dangerousZones: [
                DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332), level: .high, name: "Zócalo"),
                DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.427, longitude: -99.1677), level: .high, name: "Colonia Doctores"),
            ],
            safeZones:[
                // Delegación Cuauhtémoc
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332), name: "Refugio Seguro Zócalo"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4401, longitude: -99.1454), name: "Refugio Seguro Roma Norte"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4283, longitude: -99.1421), name: "Refugio Seguro Condesa"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4320, longitude: -99.1502), name: "Refugio Seguro Juárez"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4360, longitude: -99.1357), name: "Refugio Seguro Santa María la Ribera"),
                
                // Delegación Benito Juárez
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3849, longitude: -99.1623), name: "Refugio Seguro Nápoles"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3827, longitude: -99.1663), name: "Refugio Seguro Del Valle"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3975, longitude: -99.1620), name: "Refugio Seguro Narvarte"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4032, longitude: -99.1584), name: "Refugio Seguro Portales"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3877, longitude: -99.1600), name: "Refugio Seguro Mixcoac"),

                // Delegación Miguel Hidalgo
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4320, longitude: -99.2002), name: "Refugio Seguro Polanco"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4315, longitude: -99.2033), name: "Refugio Seguro Chapultepec"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4426, longitude: -99.2085), name: "Refugio Seguro Lomas de Chapultepec"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4526, longitude: -99.1987), name: "Refugio Seguro San Miguel Chapultepec"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4468, longitude: -99.2012), name: "Refugio Seguro Anzures"),

                // Delegación Coyoacán
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3461, longitude: -99.1617), name: "Refugio Seguro Coyoacán Centro"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3531, longitude: -99.1524), name: "Refugio Seguro Villa Coyoacán"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3545, longitude: -99.1467), name: "Refugio Seguro Churubusco"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3580, longitude: -99.1478), name: "Refugio Seguro Pedregal"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3611, longitude: -99.1645), name: "Refugio Seguro Del Carmen"),

                // Delegación Iztapalapa
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3556, longitude: -99.0883), name: "Refugio Seguro Central de Abastos"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3700, longitude: -99.0735), name: "Refugio Seguro Santa Martha"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3766, longitude: -99.0788), name: "Refugio Seguro Ermita Zaragoza"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3702, longitude: -99.0912), name: "Refugio Seguro Los Ángeles"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3645, longitude: -99.0857), name: "Refugio Seguro La Viga"),

                // Delegación Álvaro Obregón
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3691, longitude: -99.2266), name: "Refugio Seguro Santa Fe"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3667, longitude: -99.2153), name: "Refugio Seguro Mixcoac"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3748, longitude: -99.2303), name: "Refugio Seguro Las Águilas"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3766, longitude: -99.2044), name: "Refugio Seguro San Ángel"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3711, longitude: -99.2144), name: "Refugio Seguro Olivar de los Padres"),

                // Delegación Azcapotzalco
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4875, longitude: -99.1821), name: "Refugio Seguro Azcapotzalco Centro"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4813, longitude: -99.1922), name: "Refugio Seguro San Álvaro"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4712, longitude: -99.1893), name: "Refugio Seguro Santa Cruz Acayucan"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4800, longitude: -99.1789), name: "Refugio Seguro Industrial Vallejo"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4902, longitude: -99.1723), name: "Refugio Seguro Clavería"),

                // Delegación Venustiano Carranza
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4324, longitude: -99.0981), name: "Refugio Seguro Aeropuerto"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4445, longitude: -99.1090), name: "Refugio Seguro Moctezuma"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4498, longitude: -99.1225), name: "Refugio Seguro Jardín Balbuena"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4362, longitude: -99.1067), name: "Refugio Seguro Romero Rubio"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4273, longitude: -99.1121), name: "Refugio Seguro Morelos"),

                // Delegación Tlalpan
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.2923, longitude: -99.1621), name: "Refugio Seguro Tlalpan Centro"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3051, longitude: -99.1594), name: "Refugio Seguro Villa Coapa"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3125, longitude: -99.1413), name: "Refugio Seguro Huipulco"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3236, longitude: -99.1425), name: "Refugio Seguro Fuentes Brotantes"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.3289, longitude: -99.1457), name: "Refugio Seguro San Andrés Totoltepec"),

                // Delegación Xochimilco
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.2551, longitude: -99.1134), name: "Refugio Seguro Xochimilco Centro"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.2633, longitude: -99.1092), name: "Refugio Seguro La Noria"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.2724, longitude: -99.1234), name: "Refugio Seguro Tepepan"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.2601, longitude: -99.1178), name: "Refugio Seguro Santiago Tulyehualco"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.2507, longitude: -99.1211), name: "Refugio Seguro Santa Cruz Acalpixca"),

                // Delegación Gustavo A. Madero
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4854, longitude: -99.1234), name: "Refugio Seguro Lindavista"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4907, longitude: -99.1378), name: "Refugio Seguro La Villa"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4792, longitude: -99.1211), name: "Refugio Seguro San Juan de Aragón"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4692, longitude: -99.1289), name: "Refugio Seguro Progreso Nacional"),
                SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4884, longitude: -99.1423), name: "Refugio Seguro Cuautepec")
            ]
        )
        .edgesIgnoringSafeArea(.all)
    }
}

