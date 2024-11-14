//
//  ContentView.swift
//  URBN
//
//  Created by Ximena Cruz on 29/10/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var selectedView: Tab = .sos
    @State private var isTabBarHidden = false
    
    // Define la lista de zonas peligrosas con diferentes niveles
    let dangerousZones = [
        
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332), level: .high, name: "Zócalo"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.427, longitude: -99.1677), level: .high, name: "Colonia Doctores"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4436, longitude: -99.1477), level: .high, name: "Tepito"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4079, longitude: -99.1259), level: .medium, name: "Iztapalapa"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4757, longitude: -99.1101), level: .medium, name: "Gustavo A. Madero"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4322, longitude: -99.1275), level: .low, name: "Centro Histórico"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3686, longitude: -99.1619), level: .high, name: "Tláhuac"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4166, longitude: -99.1688), level: .medium, name: "Roma Norte"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3576, longitude: -99.0902), level: .low, name: "Milpa Alta"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4969, longitude: -99.1309), level: .medium, name: "La Villa"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4285, longitude: -99.1468), level: .high, name: "Guerrero"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4632, longitude: -99.1201), level: .medium, name: "Lindavista"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4861, longitude: -99.1598), level: .low, name: "Tacuba"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3669, longitude: -99.1944), level: .medium, name: "Mixcoac"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4194, longitude: -99.0896), level: .high, name: "Agrícola Oriental"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3796, longitude: -99.1525), level: .low, name: "Culhuacán"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4065, longitude: -99.1534), level: .medium, name: "Xochimilco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3292, longitude: -99.1397), level: .high, name: "San Miguel Teotongo"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4012, longitude: -99.1606), level: .medium, name: "Coyoacán"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3587, longitude: -99.0784), level: .low, name: "Chalco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3531, longitude: -99.1393), level: .high, name: "San Lorenzo Tezonco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4055, longitude: -99.1306), level: .medium, name: "Ermita Iztapalapa"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4595, longitude: -99.0737), level: .low, name: "San Juan de Aragón"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4783, longitude: -99.1335), level: .high, name: "Lindavista Sur"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3751, longitude: -99.1500), level: .medium, name: "Huipulco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3703, longitude: -99.1446), level: .low, name: "La Noria"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3601, longitude: -99.1788), level: .medium, name: "Ajusco Medio"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3555, longitude: -99.1262), level: .high, name: "Santa Catarina Yecahuitzotl"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4501, longitude: -99.1546), level: .low, name: "San Cosme"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4954, longitude: -99.1098), level: .medium, name: "San Felipe de Jesús"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3566, longitude: -99.0604), level: .high, name: "Zona Oriente"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3786, longitude: -99.1545), level: .medium, name: "Santa Ursula"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4265, longitude: -99.1456), level: .low, name: "Lagunilla"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4635, longitude: -99.0932), level: .high, name: "Martín Carrera"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4401, longitude: -99.1248), level: .medium, name: "Buenavista"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3833, longitude: -99.1895), level: .low, name: "Observatorio"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3958, longitude: -99.1485), level: .medium, name: "Azcapotzalco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4432, longitude: -99.2106), level: .high, name: "San Pedro de los Pinos"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4191, longitude: -99.1633), level: .medium, name: "Condesa"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4283, longitude: -99.1635), level: .low, name: "Polanco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3757, longitude: -99.1798), level: .medium, name: "Villa Coapa"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3972, longitude: -99.1573), level: .high, name: "San Ángel"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3765, longitude: -99.1988), level: .low, name: "Mixcoac"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3667, longitude: -99.1018), level: .medium, name: "Canal de Chalco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4074, longitude: -99.1399), level: .high, name: "Iztacalco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4621, longitude: -99.2019), level: .low, name: "Anáhuac"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3571, longitude: -99.1918), level: .medium, name: "Las Águilas"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4337, longitude: -99.1227), level: .low, name: "Revolución"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4478, longitude: -99.1964), level: .high, name: "Tacubaya"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3783, longitude: -99.0992), level: .medium, name: "Peñón Viejo"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4247, longitude: -99.1842), level: .low, name: "Escandón"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4036,
longitude: -99.1), level: .medium, name: "La Reforma"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4381, longitude: -99.1276), level: .high, name: "Morelos"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4647, longitude: -99.0865), level: .medium, name: "San Juan de Aragón"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4145, longitude: -99.0759), level: .low, name: "Agrícola Oriental"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3892, longitude: -99.0761), level: .medium, name: "Pantitlán"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3589, longitude: -99.0821), level: .high, name: "Santa Catarina"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3783, longitude: -99.1615), level: .low, name: "Villa Coyoacán"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4268, longitude: -99.1563), level: .medium, name: "Buenavista"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4512, longitude: -99.1508), level: .high, name: "Clavería"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3455, longitude: -99.0735), level: .medium, name: "Los Reyes"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4610, longitude: -99.1034), level: .low, name: "Bondojito"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3488, longitude: -99.1843), level: .high, name: "Pedregal"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4823, longitude: -99.1247), level: .medium, name: "Tlatilco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3603, longitude: -99.0715), level: .low, name: "Xalpa"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4026, longitude: -99.0869), level: .medium, name: "Santa Martha"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3691, longitude: -99.1467), level: .high, name: "Portales"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4471, longitude: -99.1855), level: .medium, name: "Tacuba"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3764, longitude: -99.1643), level: .low, name: "Del Valle"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3626, longitude: -99.0868), level: .high, name: "Santiago Acahualtepec"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4221, longitude: -99.1339), level: .medium, name: "Centro Histórico Sur"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3599, longitude: -99.1866), level: .low, name: "Nápoles"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4568, longitude: -99.1314), level: .high, name: "Industrial Vallejo"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4161, longitude: -99.1297), level: .medium, name: "Roma Norte"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3496, longitude: -99.0592), level: .low, name: "Mixquic"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3910, longitude: -99.1121), level: .high, name: "Jardín Balbuena"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4597, longitude: -99.1142), level: .medium, name: "Estrella"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4017, longitude: -99.0904), level: .low, name: "Paraje San Juan"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4409, longitude: -99.1403), level: .high, name: "Santa María la Ribera"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4306, longitude: -99.1202), level: .medium, name: "Guerrero"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3707, longitude: -99.1995), level: .low, name: "Las Águilas"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3643, longitude: -99.1494), level: .high, name: "San Simón Ticumac"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4466, longitude: -99.1285), level: .medium, name: "Peralvillo"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3959, longitude: -99.1612), level: .low, name: "San Rafael"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4150, longitude: -99.1434), level: .high, name: "Centro Médico"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3605, longitude: -99.0852), level: .medium, name: "San Lorenzo Tezonco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4802, longitude: -99.1583), level: .low, name: "La Raza"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4723, longitude: -99.1325), level: .high, name: "Santa Isabel Tola"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4143, longitude: -99.1384), level: .medium, name: "Hipódromo"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4314, longitude: -99.1389), level: .low, name: "Doctores"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3759, longitude: -99.1589), level: .high, name: "Ajusco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3801, longitude: -99.1083), level: .medium, name: "Churubusco"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4056, longitude: -99.1681), level: .low, name: "Escandón"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4484, longitude: -99.0913), level: .high, name: "La Malinche"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.4387, longitude: -99.1694), level: .medium, name: "Tacuba"),
        DangerousZone(coordinate: CLLocationCoordinate2D(latitude: 19.3863, longitude: -99.1873), level: .low, name: "Lomas de Plateros"),

        ]
    let safeZones = [
        SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4333, longitude: -99.1500), name: "Refugio Seguro 1"),
        SafeZone(coordinate: CLLocationCoordinate2D(latitude: 19.4350, longitude: -99.1520), name: "Refugio Seguro 2")
    ]
    
    var body: some View {
          VStack(spacing: 0) {
              // Cambia la vista mostrada en función de la selección
              Group {
                  switch selectedView {
                  case .map:
                      VStack {
                          TripMapView(dangerousZones: dangerousZones, safeZones: safeZones)
                              .frame(maxWidth: .infinity, maxHeight: .infinity)
                          
                          // Leyenda descriptiva para los colores de peligro
                          VStack(spacing: 8) {
                              Text("Niveles de Peligro")
                                  .font(.headline)
                                  .padding(.bottom, 5)

                              HStack(spacing: 15) {
                                  HStack(spacing: 5) {
                                      Circle().fill(Color.red).frame(width: 14, height: 14)
                                      Text("Alto Peligro")
                                          .font(.caption)
                                          .bold()
                                      
                                          .font(.caption)
                                          .foregroundColor(.gray)
                                  }
                                  
                                  HStack(spacing: 5) {
                                      Circle().fill(Color.orange).frame(width: 14, height: 14)
                                      Text("Peligro Medio")
                                          .font(.caption)
                                          .bold()
                                      
                                          .font(.caption)
                                          .foregroundColor(.gray)
                                  }
                                  
                                  HStack(spacing: 5) {
                                      Circle().fill(Color.yellow).frame(width: 14, height: 14)
                                      Text("Bajo Peligro")
                                          .font(.caption)
                                          .bold()
                                    
                                          .font(.caption)
                                          .foregroundColor(.gray)
                                  }
                              }
                              .padding(.vertical, 10)
                              .padding(.horizontal, 20)
                              .background(Color.white.opacity(0.95))
                              .cornerRadius(12)
                              .shadow(radius: 4)
                              .padding(.horizontal, 20)
                              .padding(.bottom, 10)
                          }
                      }
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

              // Coloca el TabBar personalizado en la parte inferior
              TabBarView(selectedView: $selectedView)
                  .frame(height: 50)
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
