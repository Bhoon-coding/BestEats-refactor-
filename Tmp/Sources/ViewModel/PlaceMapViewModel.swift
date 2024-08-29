//
//  PlaceMapViewModel.swift
//  BestEats
//
//  Created by BH on 2024/08/09.
//

import Foundation
import MapKit
import SwiftUI

final class PlaceMapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var placeList: [V2.Local.Search.Keyword.Response.PlaceInfo] = []
    @Published var place: V2.Local.Search.Keyword.Response.PlaceInfo?
    
    private let locationManager = LocationManager.shared
    
    init() { }
    
    @MainActor
    func fetchNearRestaurant(foodType: FoodType) async {
        let coordinate: CLLocationCoordinate2D = self.region.center
        let params: V2.Local.Search.Keyword.Params = .init(
            query: foodType.rawValue,
            x: "\(coordinate.longitude)",
            y: "\(coordinate.latitude)"
        )
        
        do {
            let response = try await SearchRestaurantService().request(params: params)
            self.placeList = response.restaurantInfo ?? []
            
            if let nearestPlace = placeList.first {
                self.place = nearestPlace
            }
            
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
        }
    }
    
    func setInfoNearPlaceCount() -> String {
        let placeCount: Int = placeList.count
        return "근처에 \(placeCount)개의 맛집이 있어요!"
    }
    
    func setPlaceName() -> String {
        return self.place?.placeName ?? PlaceInfoError.emptyData.messageDescription
    }
    
    func setCategoryName() -> String {
        guard let categoryName = self.place?.categoryName else {
            return PlaceInfoError.emptyData.messageDescription
        }
        return categoryName
    }
    
    func setAddressName() -> String {
        guard let roadAddress = self.place?.roadAddressName else {
            return self.place?.addressName ?? PlaceInfoError.emptyData.messageDescription
        }
        return roadAddress
    }
    
    func setDistance() -> String {
        guard let validDistance = self.place?.distance,
              let distanceValue = Double(validDistance) else {
            return PlaceInfoError.emptyData.messageDescription
        }
        
        return distanceValue.convertedDistance()
    }
    
    func makeCall() {
        let telephone = "tel://"
        let formattedString = telephone + (place?.phone ?? "")
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }
}
