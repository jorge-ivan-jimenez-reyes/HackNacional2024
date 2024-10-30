//
//  TabBarView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedView: Tab

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                selectedView = .map
            }) {
                Image(systemName: selectedView == .map ? "map.fill" : "map")
                    .resizable()
                    .frame(width: 30, height: 25)
                    .foregroundColor(.red)
            }
            Spacer()
            Button(action: {
                selectedView = .community
            }) {
                Image(systemName: selectedView == .community ? "person.3.fill" : "person.3")
                    .resizable()
                    .frame(width: 45, height: 30)
                    .foregroundColor(.red)
            }
            Spacer()
            Button(action: {
                selectedView = .sos // Mantener el botón central sin cambio
            }) {
                ZStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 60, height: 60)
                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 2, y: 3)
                    
                    Image(systemName: "exclamationmark.shield.fill")
                        .resizable()
                        .frame(width: 30, height: 35)
                        .foregroundColor(.white)
                }
            }
            Spacer()
            Button(action: {
                selectedView = .publish
            }) {
                Image(systemName: selectedView == .publish ? "plus.app.fill" : "plus.app")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
            }
            Spacer()
            Button(action: {
                selectedView = .settings
            }) {
                Image(systemName: selectedView == .settings ? "person.fill" : "person")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
            }
            Spacer()
        }
        .padding(.bottom, 20)
        .frame(height: 60)
        .background(Color.white)
    }
}