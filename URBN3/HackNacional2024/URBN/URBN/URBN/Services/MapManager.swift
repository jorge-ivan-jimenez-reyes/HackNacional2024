//
//  MapManager.swift
//  URBN
//
//  Created by Jorge Ivan Jimenez Reyes  on 10/11/24.
//



import MapKit
import SwiftData

enum MapManager {
    @MainActor
    static func searchPlaces(_ modelContext: ModelContext, searchText: String, visibleRegion: MKCoordinateRegion?) async {
        removeSearchResults(modelContext)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        if let visibleRegion {
            request.region = visibleRegion
        }
        let searchItems = try? await MKLocalSearch(request: request).start()
        let results = searchItems?.mapItems ?? []
        results.forEach {
            let mtPlacemark = MTPlacemark(
                name: $0.placemark.name ?? "",
                address: $0.placemark.title ?? "",
                latitude: $0.placemark.coordinate.latitude,
                longitude: $0.placemark.coordinate.longitude
            )
            modelContext.insert(mtPlacemark)
        }
    }
    
    static let dangerousLocations: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332),  // Zócalo
        CLLocationCoordinate2D(latitude: 19.427, longitude: -99.1677),   // Colonia Doctores
        CLLocationCoordinate2D(latitude: 19.4436, longitude: -99.1477),  // Tepito
        CLLocationCoordinate2D(latitude: 19.4079, longitude: -99.1259),  // Iztapalapa
        CLLocationCoordinate2D(latitude: 19.4757, longitude: -99.1101),  // Gustavo A. Madero
        CLLocationCoordinate2D(latitude: 19.4322, longitude: -99.1275),  // Centro Histórico
        CLLocationCoordinate2D(latitude: 19.3686, longitude: -99.1619),  // Tláhuac
        CLLocationCoordinate2D(latitude: 19.4166, longitude: -99.1688),  // Roma Norte
        CLLocationCoordinate2D(latitude: 19.3576, longitude: -99.0902),  // Milpa Alta
        CLLocationCoordinate2D(latitude: 19.4969, longitude: -99.1309),  // La Villa
        CLLocationCoordinate2D(latitude: 19.4285, longitude: -99.1468),  // Guerrero
        CLLocationCoordinate2D(latitude: 19.4632, longitude: -99.1201),  // Lindavista
        CLLocationCoordinate2D(latitude: 19.4861, longitude: -99.1598),  // Tacuba
        CLLocationCoordinate2D(latitude: 19.3669, longitude: -99.1944),  // Mixcoac
        CLLocationCoordinate2D(latitude: 19.4194, longitude: -99.0896),  // Agrícola Oriental
        CLLocationCoordinate2D(latitude: 19.3796, longitude: -99.1525),  // Culhuacán
        CLLocationCoordinate2D(latitude: 19.4065, longitude: -99.1534),  // Xochimilco
        CLLocationCoordinate2D(latitude: 19.3292, longitude: -99.1397),  // San Miguel Teotongo
        CLLocationCoordinate2D(latitude: 19.4012, longitude: -99.1606),  // Coyoacán
        CLLocationCoordinate2D(latitude: 19.3587, longitude: -99.0784),  // Chalco (área cercana)
        CLLocationCoordinate2D(latitude: 19.3531, longitude: -99.1393),  // San Lorenzo Tezonco
        CLLocationCoordinate2D(latitude: 19.4055, longitude: -99.1306),  // Ermita Iztapalapa
        CLLocationCoordinate2D(latitude: 19.4595, longitude: -99.0737),  // San Juan de Aragón
        CLLocationCoordinate2D(latitude: 19.4783, longitude: -99.1335),  // Lindavista Sur
        CLLocationCoordinate2D(latitude: 19.3751, longitude: -99.1500),  // Huipulco
        CLLocationCoordinate2D(latitude: 19.3703, longitude: -99.1446),  // La Noria
        CLLocationCoordinate2D(latitude: 19.3601, longitude: -99.1788),  // Ajusco Medio
        CLLocationCoordinate2D(latitude: 19.3555, longitude: -99.1262),  // Santa Catarina Yecahuitzotl
        CLLocationCoordinate2D(latitude: 19.4501, longitude: -99.1546),  // San Cosme
        CLLocationCoordinate2D(latitude: 19.4954, longitude: -99.1098)   // San Felipe de Jesús
    ]

    
    
    static func removeSearchResults(_ modelContext: ModelContext) {
        let searchPredicate = #Predicate<MTPlacemark> { $0.TripDestination == nil }
        try? modelContext.delete(model: MTPlacemark.self, where: searchPredicate)
    }
}
