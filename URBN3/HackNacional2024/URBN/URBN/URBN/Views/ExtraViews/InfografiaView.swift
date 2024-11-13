//
//  InfografiaView.swift
//  URBN
//
//  Created by Ximena Cruz on 12/11/24.
//

import SwiftUI

struct InfografiaView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
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
                    
                    Text("Sismo")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        // Acción para bookmark
                    }) {
                        Image(systemName: "bookmark.fill")
                            .font(.title)
                            .foregroundColor(Color.red)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Sección: Antes
                        SeccionInfografiaView(
                            titulo: "Antes",
                            color: .blue,
                            items: [
                                SectionItemView(title: "Preparar Documentos y Objetos Importantes", content: [
                                    "Copia o escanea documentos importantes y guárdalos en una USB.",
                                    "Mantén las llaves del automóvil a la mano.",
                                    "Prepara una bolsa impermeabilizada para objetos personales importantes."
                                ]),
                                SectionItemView(title: "Alimentos y Medicamentos", content: [
                                    "Verifica la fecha de caducidad de alimentos y medicamentos.",
                                    "Almacena alimentos no perecederos y agua.",
                                    "Guarda un abrelatas manual."
                                ]),
                                SectionItemView(title: "Herramientas y Suministros", content: [
                                    "Ten una linterna con pilas adicionales.",
                                    "Guarda dinero en efectivo.",
                                    "Prepara un radio con pilas y un celular cargado para emergencias."
                                ])
                            ]
                        )
                        
                        // Sección: Durante
                        SeccionInfografiaView(
                            titulo: "Durante",
                            color: .orange,
                            items: [
                                SectionItemView(title: "Mantén la Calma y Evalúa tu Situación", content: [
                                    "Respira hondo y mantén la calma.",
                                    "Si estás en un piso bajo, evacúa siguiendo rutas establecidas.",
                                    "Si estás en un piso alto, repliégate a la zona de menor riesgo."
                                ]),
                                SectionItemView(title: "Precauciones en Espacios Interiores", content: [
                                    "Aléjate de ventanas y objetos que puedan caer.",
                                    "Ayuda a personas vulnerables a replegarse a zonas de seguridad."
                                ])
                            ]
                        )
                        
                        // Sección: Después
                        SeccionInfografiaView(
                            titulo: "Después",
                            color: .green,
                            items: [
                                SectionItemView(title: "Evacuación y Seguridad", content: [
                                    "Dirígete al punto de reunión establecido.",
                                    "No regreses al inmueble si detectas daños estructurales."
                                ]),
                                SectionItemView(title: "Corte de Suministros", content: [
                                    "Si es seguro, corta los servicios de gas, agua y electricidad.",
                                    "Evita usar velas o fumar hasta descartar fugas de gas."
                                ])
                            ]
                        )
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct SeccionInfografiaView: View {
    var titulo: String
    var color: Color
    var items: [SectionItemView]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(color)
                Text(titulo)
                    .font(.title3)
                    .bold()
                    .foregroundColor(color)
            }
            .padding(.bottom, 5)
            
            ForEach(items.indices, id: \.self) { index in
                items[index]
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: color.opacity(0.3), radius: 4, x: 2, y: 2)
                    .frame(maxWidth: .infinity) // Mantiene el tamaño uniforme de los contenedores
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(15)
        .shadow(radius: 4)
        
    }
}

struct SectionItemView: View, Identifiable {
    let id = UUID()
    var title: String
    var content: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(content, id: \.self) { text in
                HStack(alignment: .top, spacing: 8) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 6, height: 6)
                        .alignmentGuide(.top) { d in d[.bottom] / 2 }
                    Text(text)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

struct InfografiaView_Previews: PreviewProvider {
    static var previews: some View {
        InfografiaView()
    }
}
