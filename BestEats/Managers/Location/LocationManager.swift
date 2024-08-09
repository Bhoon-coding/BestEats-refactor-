//
//  LocationManager.swift
//  BestEats
//
//  Created by BH on 2024/08/08.
//

import CoreLocation

final class LocationManager: NSObject {
    
    static let shared = LocationManager()

    private var manager = CLLocationManager()
    private var retryCount: Int = 0
    var locationCompletion: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func startUpdateLocation() {
        manager.startUpdatingLocation()
    }
    
    func stopLocationManager() {
        manager.stopUpdatingLocation()
    }
}

// MARK: - Delegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("auth: restricted")
        case .denied:
            // TODO: [] 위치 권한 동의유도 안내 팝업
            print("auth: denied")
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("auth: authorizedAlways | authorizedWhenInUse")
            startUpdateLocation()
        @unknown default:
            print("auth: @unknown default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationCompletion?(location)
            stopLocationManager()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error: \(error.localizedDescription)")
        
        if retryCount < 3 {
            retryCount += 1
            startUpdateLocation()
            print("retryCount: \(retryCount)")
        } else {
            retryCount = 0
            print("잠시후 다시 시도해주세요")
        }
    }
}

