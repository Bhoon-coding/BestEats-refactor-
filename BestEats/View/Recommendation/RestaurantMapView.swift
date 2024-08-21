//
//  RecommendationView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI
import MapKit

struct RestaurantMapView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = RestaurantMapViewModel()
    @State private var isPresentedSheet: Bool = false
    @State private var selectedId: UUID?
    @State var foodType: FoodType = .cafe
    
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $vm.region,
                showsUserLocation: true,
                //                userTrackingMode: .constant(.follow),
                annotationItems: vm.nearRestaurants
            ) { nearPlace in
                MapAnnotation(coordinate: nearPlace.coordinate) {
                    CustomMapMarkerView(selectedId: $selectedId, restaurant: nearPlace, type: foodType)
                }
            }
            .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .trailing) {
                Button(action: {
                    self.isPresentedSheet = true
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 60, height: 54)
                        .font(.pretendardBold18)
                        .foregroundStyle(.white)
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.vertical, 24)
                        .padding(.trailing, -8)
                })
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        vm.getCurrentLocation()
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
            self.isPresentedSheet = true
        }
        .onChange(of: selectedId) { newId in
            if let selectedRestaurant = vm.nearRestaurants.first(where: { $0.id == newId }) {
                zoomToLocation(location: selectedRestaurant.coordinate)
            }
        }
        .onChange(of: foodType) { newFoodType in
            Task { await vm.fetchNearRestaurant(foodType: newFoodType) }
        }
        .sheet(isPresented: $isPresentedSheet) {
                FoodTypeSheetView(foodType: $foodType)
                .presentationDetents([.fraction(0.5), .large])
                .presentationDragIndicator(.visible)
            }
    }
    
    private func zoomToLocation(location: CLLocationCoordinate2D) {
        withAnimation(.easeIn) {
            vm.region.center = location
        }
    }
}

#Preview {
    @State var type: FoodType = .cafe
    return RestaurantMapView(foodType: type)
}
