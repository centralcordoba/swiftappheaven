import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!
    var zoomInButton: UIButton!
    var zoomOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        mapView.delegate = self
        view.addSubview(mapView)

        // Configura el mapa en una ubicación inicial
        let initialRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.416775, longitude: -3.703790), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(initialRegion, animated: true)

        // Añade un reconocedor de gestos para detectar toques en el mapa
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)

        // Crea botones de zoom
        zoomInButton = UIButton(type: .system)
        zoomInButton.setTitle("Zoom In", for: .normal)
        view.addSubview(zoomInButton)
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        zoomInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        zoomInButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        zoomInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        zoomInButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)

        zoomOutButton = UIButton(type: .system)
        zoomOutButton.setTitle("Zoom Out", for: .normal)
        view.addSubview(zoomOutButton)
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        zoomOutButton.leadingAnchor.constraint(equalTo: zoomInButton.trailingAnchor, constant: 20).isActive = true
        zoomOutButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        zoomOutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        zoomOutButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
    }

    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

        // Puedes mostrar un UIAlertController aquí para recopilar información del usuario
        let alertController = UIAlertController(title: "Nueva Persona", message: "Ingrese los datos a continuación", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Sexo"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Edad"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Needs"
        }

        let saveAction = UIAlertAction(title: "Guardar", style: .default) { [unowned alertController] _ in
            let sex = alertController.textFields?[0].text ?? ""
            let age = alertController.textFields?[1].text ?? ""
            let needs = alertController.textFields?[2].text ?? ""
            self.addAnnotationAt(coordinate: coordinate, sex: sex, age: age, needs: needs)
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    func addAnnotationAt(coordinate: CLLocationCoordinate2D, sex: String, age: String, needs: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(sex), \(age)"
        annotation.subtitle = needs
        mapView.addAnnotation(annotation)
    }

    @objc func zoomIn() {
        // Aumenta el nivel de zoom
        var region = mapView.region
        region.span.latitudeDelta /= 2.0
        region.span.longitudeDelta /= 2.0
        mapView.setRegion(region, animated: true)
    }

    @objc func zoomOut() {
        // Reduce el nivel de zoom
        var region = mapView.region
        region.span.latitudeDelta *= 2.0
        region.span.longitudeDelta *= 2.0
        mapView.setRegion(region, animated: true)
    }
}

