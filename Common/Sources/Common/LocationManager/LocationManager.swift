//
//  LocationManager.swift
//  Common
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation
import CoreLocation
import Combine

public class LocationManager: NSObject, ObservableObject {
    @Published public var userCountry: String?
    @Published public var locationPermissionDenied = false

    private let locationManager = CLLocationManager()
    private var cancellable = Set<AnyCancellable>()
    private var geocoder = CLGeocoder()

    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    public func fetchLocation() {
        let authorizationStatus = locationManager.authorizationStatus
        handleAuthorization(status: authorizationStatus)
    }

    private func handleAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            NotificationCenter.default.post(name: .locationAuthorization,
                                            object: nil,
                                            userInfo: ["isAuthorized": false])
        case .restricted, .denied:
            locationPermissionDenied = true
            NotificationCenter.default.post(name: .locationAuthorization,
                                            object: nil,
                                            userInfo: ["isAuthorized": false])
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            NotificationCenter.default.post(name: .locationAuthorization,
                                            object: nil,
                                            userInfo: ["isAuthorized": true])
        @unknown default:
            locationPermissionDenied = true
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorization(status: manager.authorizationStatus)
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self, error == nil, let placemark = placemarks?.first else { return }
            self.userCountry = placemark.isoCountryCode
        }
        manager.stopUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error.localizedDescription)")
    }
}
