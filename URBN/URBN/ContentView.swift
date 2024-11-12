//
//  ContentView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedView: Tab = .sos
    @State private var isTabBarHidden = false

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedView {
                case .map:
                    TripMapView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .community:
                    CommunityView(isTabBarHidden: $isTabBarHidden) // Pasa el binding de isTabBarHidden
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            if !isTabBarHidden {
                TabBarView(selectedView: $selectedView)
                    .frame(height: 50)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

enum Tab {
    case sos, community, settings, map, publish
}

#Preview {
    ContentView()
}
