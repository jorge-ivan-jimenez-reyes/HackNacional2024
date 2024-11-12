import SwiftUI
import MapKit

struct DangerousZone {
    let coordinate: CLLocationCoordinate2D
    let level: DangerLevel
    let name: String
}

enum DangerLevel {
    case high, medium, low
}

struct TripMapView: UIViewRepresentable {
    @Environment(LocationManager.self) var locationManager
    
    let dangerousZones: [DangerousZone]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        
        // Agrega un overlay de círculo y un marcador con el nombre para cada zona peligrosa
        for zone in dangerousZones {
            let circle = MKCircle(center: zone.coordinate, radius: 500)
            mapView.addOverlay(circle)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = zone.coordinate
            annotation.title = zone.name
            mapView.addAnnotation(annotation)
        }
        
        // Centra el mapa en la ubicación del usuario cuando se carga
        if let userLocation = locationManager.userLocation {
            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
            mapView.setRegion(region, animated: true)
        }
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let userLocation = locationManager.userLocation {
            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
            uiView.setRegion(region, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: TripMapView

        init(_ parent: TripMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let circleOverlay = overlay as? MKCircle else { return MKOverlayRenderer(overlay: overlay) }
            
            let circleRenderer = MKCircleRenderer(circle: circleOverlay)
            
            if let zone = parent.dangerousZones.first(where: { $0.coordinate.latitude == circleOverlay.coordinate.latitude && $0.coordinate.longitude == circleOverlay.coordinate.longitude }) {
                
                switch zone.level {
                case .high:
                    circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.4)
                    circleRenderer.strokeColor = UIColor.red
                case .medium:
                    circleRenderer.fillColor = UIColor.orange.withAlphaComponent(0.3)
                    circleRenderer.strokeColor = UIColor.orange
                case .low:
                    circleRenderer.fillColor = UIColor.yellow.withAlphaComponent(0.2)
                    circleRenderer.strokeColor = UIColor.yellow
                }
                circleRenderer.lineWidth = 1.5
            }
            return circleRenderer
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let identifier = "DangerousZone"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                // Personalización de la vista de la etiqueta
                annotationView?.glyphText = "⚠️"
                annotationView?.titleVisibility = .adaptive
                annotationView?.subtitleVisibility = .adaptive
                annotationView?.displayPriority = .required
                annotationView?.canShowCallout = true
                
                // Botón de información adicional en el “callout”
                let infoButton = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = infoButton
            } else {
                annotationView?.annotation = annotation
            }
            
            if let dangerousZoneAnnotation = annotation as? MKPointAnnotation,
               let zone = parent.dangerousZones.first(where: { $0.name == dangerousZoneAnnotation.title }) {
                
                // Cambia el color del marcador en función del nivel de peligro
                switch zone.level {
                case .high:
                    annotationView?.markerTintColor = UIColor.red
                    annotationView?.glyphText = "🔴"
                case .medium:
                    annotationView?.markerTintColor = UIColor.orange
                    annotationView?.glyphText = "🟠"
                case .low:
                    annotationView?.markerTintColor = UIColor.yellow
                    annotationView?.glyphText = "🟡"
                }
                
                annotationView?.detailCalloutAccessoryView = createCustomCallout(for: zone)
            }
            
            return annotationView
        }
        
        // Método para crear un “callout” personalizado
        private func createCustomCallout(for zone: DangerousZone) -> UIView {
            let label = UILabel()
            label.text = "Zona: \(zone.name)\nNivel de peligro: \(zone.level == .high ? "Alto" : zone.level == .medium ? "Medio" : "Bajo")"
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .footnote)
            return label
        }
    }
}
