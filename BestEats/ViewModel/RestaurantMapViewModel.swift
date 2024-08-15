//
//  RestaurantMapViewModel.swift
//  BestEats
//
//  Created by BH on 2024/08/09.
//

import Foundation
import MapKit

@MainActor
final class RestaurantMapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var nearRestaurant: [V2.Local.Search.Keyword.Response.RestaurantInfo] = []
    
    private let locationManager = LocationManager.shared
    
    init() {
        getCurrentLocation()
    }
    
    private func fetchNearRestaurant() async {
        let coordinate: CLLocationCoordinate2D = self.region.center
        
        let params: V2.Local.Search.Keyword.Params = .init(
            query: "카페",
            x: "\(coordinate.longitude)",
            y: "\(coordinate.latitude)"
        )
        
        do {
            let response = try await SearchRestaurantService().request(params: params)
            DispatchQueue.main.async {
                self.nearRestaurant = response.restaurantInfo ?? []
            }
        } catch {
            DispatchQueue.main.async {
                print(#function, "Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func getCurrentLocation() {
        locationManager.locationCompletion = { [weak self] location in
            guard let self = self else { return }
            let span: MKCoordinateSpan = .init(latitudeDelta: 0.006, longitudeDelta: 0.006)
            self.region = .init(center: location.coordinate, span: span)
            
            Task {
                await self.fetchNearRestaurant()
            }
        }
    }
    
    func didTapCurrentLocation() {
        locationManager.startUpdateLocation()
        getCurrentLocation()
    }
}
