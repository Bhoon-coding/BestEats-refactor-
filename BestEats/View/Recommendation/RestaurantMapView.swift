//
//  RecommendationView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI
import MapKit

struct RestaurantMapView: View {
    
    @StateObject private var vm = RestaurantMapViewModel()
    
    @State private var selectedId: UUID?
    
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $vm.region,
                showsUserLocation: true,
                //                userTrackingMode: .constant(.follow),
                annotationItems: vm.nearRestaurants
            ) { nearPlace in
                MapAnnotation(coordinate: nearPlace.coordinate) {
                    CustomMapMarkerView(selectedId: $selectedId, restaurant: nearPlace, type: .korean)
                }
            }
            .ignoresSafeArea(edges: .top)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        vm.didTapCurrentLocation()
                    }, label: {
                        Image(Img.currentLocation)
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                            .padding()
                    })
                }
            }
        }
        .onAppear {
            vm.getCurrentLocation()
        }
        .onChange(of: selectedId) { newId in
            if let selectedRestaurant = vm.nearRestaurants.first(where: { $0.id == newId }) {
                zoomToLocation(location: selectedRestaurant.coordinate)
            }
        }
    }
    
    private func zoomToLocation(location: CLLocationCoordinate2D) {
        withAnimation(.easeIn) {
            vm.region.center = location
        }
    }
}

#Preview {
    RestaurantMapView()
    
}
