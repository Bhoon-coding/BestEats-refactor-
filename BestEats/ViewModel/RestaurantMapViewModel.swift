//
//  RestaurantMapViewModel.swift
//  BestEats
//
//  Created by BH on 2024/08/09.
//

import Foundation
import MapKit

final class RestaurantMapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    
    private let locationManager = LocationManager.shared
    
    init() {
        getCurrentLocation()
        
    }
    
    private func getCurrentLocation() {
        locationManager.locationCompletion = { [weak self] location in
            let span: MKCoordinateSpan = .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
            self?.region = .init(center: location.coordinate, span: span)
        }
    }
    
    // TODO: [] 현재위치 누르면 startUpdateLocation 다시 활성화
}
