import SwiftUI
import MapKit

struct MapViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        // Aquí puedes actualizar tu MapViewController, si es necesario.
    }
}
