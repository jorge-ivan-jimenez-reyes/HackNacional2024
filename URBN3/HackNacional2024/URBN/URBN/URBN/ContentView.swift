//
//  ContentView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedView: Tab = .sos

    var body: some View {
        VStack(spacing: 0) {
            // Cambia la vista mostrada en función de la selección
            Group {
                switch selectedView {
                case .map:
                    MapView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .community:
                    CommunityView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .sos:
                    SOSView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .publish:
                    PublishView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .settings:
                    SettingsView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Asegura que la vista ocupada esté centrada y no empujada

            // Coloca el TabBar personalizado en la parte inferior
            TabBarView(selectedView: $selectedView)
                .frame(height: 50) // Ajusta la altura del TabBar si es necesario
        }
        .ignoresSafeArea(.keyboard) // Ignora el área de teclado en caso de que cause desplazamiento
    }
}

enum Tab {
    case sos, community, settings, map, publish
}

#Preview {
    ContentView()
}
