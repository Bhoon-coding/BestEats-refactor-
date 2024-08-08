//
//  LocationManager.swift
//  BestEats
//
//  Created by BH on 2024/08/08.
//

import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var currentLocation: CLLocationCoordinate2D?
    var manager = CLLocationManager()
    
    func checkLocationAuth() {
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("auth: restricted")
        case .denied:
            // TODO: [] 위치 권한 동의유도 안내 팝업
            print("auth: denied")
        case .authorizedAlways:
            print("auth: authorizedAlways")
            currentLocation = manager.location?.coordinate
        case .authorizedWhenInUse:
            print("auth: authorizedWhenInUse")
            currentLocation = manager.location?.coordinate
        case .authorized:
            print("auth: authorized")
            currentLocation = manager.location?.coordinate
        @unknown default:
            print("auth: @unknown default")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first?.coordinate
        print(#function, "currentLocation: \(currentLocation)")
    }
    
    func requestCurrentLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error: \(error.localizedDescription)")
    }
}

