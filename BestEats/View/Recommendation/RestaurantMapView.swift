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
    
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $vm.region,
                showsUserLocation: true,
                //                userTrackingMode: .constant(.follow),
                annotationItems: vm.nearRestaurants
            ) { nearPlace in
                MapAnnotation(coordinate: nearPlace.coordinate) {
                    CustomMapMarkerView(name: nearPlace.placeName ?? "", type: .western)
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
    }
}

#Preview {
    RestaurantMapView()
    
}
