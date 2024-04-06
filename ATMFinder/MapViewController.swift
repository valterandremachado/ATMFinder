//
//  ViewController.swift
//  ATMFinder
//
//  Created by Valter Machado on 3/31/24.
//

import SwiftUI
import UIKit
import LBTATools
import MapboxMaps
import CoreLocation


class MapViewController: UIViewController, AppleLocationProviderDelegate, CLLocationManagerDelegate {
    

    // MARK: - Properties
    private var mapView: MapView!
    let locationProvider = AppleLocationProvider()
    let locationManager = CLLocationManager()


    // MARK: - Inits
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Methods
    private func setupViews() {
        
        setupMaps()
        configaLocationManager()
    }
    
    func setupMaps() {
//        mapView = MapView(frame: view.bounds)
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        let center = CLLocationCoordinate2D(latitude: 0, longitude: 0)
//        let cameraOptions = CameraOptions(center: center, zoom: 15, bearing: 0, pitch: 45)
//        mapView.mapboxMap.setCamera(to: cameraOptions)
//        mapView.mapboxMap.styleURI = .dark
////        mapView.ornaments.options.scaleBar.visibility = .visible
//        mapView.location.override(provider: locationProvider)
//        locationProvider.delegate = self
//
//        view.addSubview(mapView)
    }
    
    func configaLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        // Get user location
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            print("Location: \(placemark.postalAddressFormatted ?? "")")
        }
        
        // Config MapView
        mapView = MapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let cameraOptions = CameraOptions(center: center, zoom: 15, bearing: 0, pitch: 0)
        mapView.mapboxMap.setCamera(to: cameraOptions)
        mapView.mapboxMap.styleURI = .dark

        var configuration = Puck2DConfiguration.makeDefault(showBearing: true)
        configuration.pulsing = .default

        mapView.location.options.puckType = .puck2D(configuration)
        view.addSubview(mapView)

        // TODO: - Show exact user location displayed with a pulsing icon

        // TODO: - Annotate ATM array to be display on the map with its respective icons (maybe nane)
        // Annotations
//        var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
//        pointAnnotation.image = .init(image: UIImage(systemName: "image")!, name: "image")
//        pointAnnotation.iconAnchor = .bottom
//        pointAnnotation.textField = "ATM Name"
//        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
//        pointAnnotationManager.annotations = [pointAnnotation]

        // Delegates
        locationProvider.delegate = self
        self.locationManager.stopUpdatingLocation()
    }
    
    private func  locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print ("Errors:" + error.localizedDescription)
    }
    
    
    // Method that will be called as a result of the delegate below
    func requestPermissionsButtonTapped() {
        locationProvider.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "LocationAccuracyAuthorizationDescription")
    }

    func appleLocationProvider(
           _ locationProvider: MapboxMaps.AppleLocationProvider,
           didChangeAccuracyAuthorization accuracyAuthorization: CLAccuracyAuthorization
    ) {
        if accuracyAuthorization == .reducedAccuracy {
            // Perform an action in response to the new change in accuracy
//            mapView.location.override(provider: locationProvider)
        }
    }

    func appleLocationProvider(_ locationProvider: MapboxMaps.AppleLocationProvider, didFailWithError error: Error) {
        print("didFailWithError")
    }
    
    func appleLocationProviderShouldDisplayHeadingCalibration(_ locationProvider: MapboxMaps.AppleLocationProvider) -> Bool {
        print("locationProvider")
        return true
    }
    
    
    
}

