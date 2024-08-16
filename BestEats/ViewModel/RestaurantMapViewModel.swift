//
//  RestaurantMapViewModel.swift
//  BestEats
//
//  Created by BH on 2024/08/09.
//

import Foundation
import MapKit

final class RestaurantMapViewModel: ObservableObject {
    // TODO: [] Publishing 에러 수정필요 (View에서 @State로 관리하면 해결되지만 그럼 뷰 모델이 불필요해짐)
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var nearRestaurants: [V2.Local.Search.Keyword.Response.RestaurantInfo] = []
    
    private let locationManager = LocationManager.shared
    
    init() { }
    
    private func fetchNearRestaurant() async {
        let coordinate: CLLocationCoordinate2D = self.region.center
        
        let params: V2.Local.Search.Keyword.Params = .init(
            query: "카페",
            x: "\(coordinate.longitude)",
            y: "\(coordinate.latitude)"
        )
        
        do {
            let response = try await SearchRestaurantService().request(params: params)
            self.nearRestaurants = response.restaurantInfo ?? []
            
        } catch {
            print(#function, "Error: \(error.localizedDescription)")
            
        }
    }
    
    func getCurrentLocation() {
        locationManager.locationCompletion = { [weak self] coordinate in
            guard let self = self else { return }
            // span: 카메라 줌
            let span: MKCoordinateSpan = .init(latitudeDelta: 0.006, longitudeDelta: 0.006)
            self.region = .init(center: coordinate, span: span)
            
            Task { await self.fetchNearRestaurant() }
        }
    }
    
    func didTapCurrentLocation() {
        locationManager.startUpdateLocation()
        getCurrentLocation()
    }
}
