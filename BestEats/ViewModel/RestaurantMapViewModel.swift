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
    @Published var nearRestaurants: [V2.Local.Search.Keyword.Response.RestaurantInfo] = []
    
    private let locationManager = LocationManager.shared
    
    init() { }
    
    @MainActor
    func fetchNearRestaurant(foodType: FoodType) async {
        let coordinate: CLLocationCoordinate2D = self.region.center
        let params: V2.Local.Search.Keyword.Params = .init(query: foodType.rawValue,
                                                           x: "\(coordinate.longitude)",
                                                           y: "\(coordinate.latitude)")
        
        do {
            let response = try await SearchRestaurantService().request(params: params)
            self.nearRestaurants = response.restaurantInfo ?? []
            
        } catch {
            print(#function, "Error: \(error.localizedDescription)")
            
        }
    }
    
    func getCurrentLocation() {
        locationManager.startUpdateLocation()
        locationManager.locationCompletion = { [weak self] coordinate in
            guard let self = self else { return }
            // span: 카메라 줌
            let span: MKCoordinateSpan = .init(latitudeDelta: 0.006, longitudeDelta: 0.006)
            self.region = .init(center: coordinate, span: span)
            
            Task { await self.fetchNearRestaurant(foodType: .cafe) }
        }
    }
}
