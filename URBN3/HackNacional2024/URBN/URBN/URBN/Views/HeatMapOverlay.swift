import MapKit
import SwiftUI

struct HeatMapOverlay: UIViewRepresentable {
    let dangerousLocations: [CLLocationCoordinate2D]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Agrega un círculo en cada ubicación peligrosa
        for location in dangerousLocations {
            let circle = MKCircle(center: location, radius: 500) // Ajusta el radio según la intensidad deseada
            mapView.addOverlay(circle)
        }
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Actualiza el mapa si es necesario
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: HeatMapOverlay

        init(_ parent: HeatMapOverlay) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circleOverlay = overlay as? MKCircle {
                let circleRenderer = MKCircleRenderer(circle: circleOverlay)
                circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.3) // Color y opacidad de la burbuja
                circleRenderer.strokeColor = UIColor.red
                circleRenderer.lineWidth = 1
                return circleRenderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
