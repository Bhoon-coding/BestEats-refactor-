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
    
    private var map: some View {
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
    }
    
    private var searchedPlaceText: some View {
        Text("근처에 n개의 맛집이 있어요!")
            .font(.pretendardBold14)
            .foregroundStyle(.white)
            .padding()
            .background(.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var searchButton: some View {
        Button(action: {
            self.isPresentedSheet = true
        }, label: {
            Image(systemName: "line.3.horizontal")
                .font(.pretendardBold18)
        })
        .frame(width: 48, height: 48)
        .foregroundStyle(.white)
        .background(.green)
        .clipShape(Circle())
    }
    
    private var currentLocationButton: some View {
        Button(action: {
            vm.getCurrentLocation()
        }, label: {
            Image(Img.currentLocation)
                .resizable()
                .clipShape(Circle())
        })
        .frame(width: 48, height: 48)
    }
    
    var body: some View {
        ZStack {
            map
            
            VStack {
                ZStack {
                    searchedPlaceText
                    
                    HStack {
                        Spacer()
                        
                        searchButton
                    }
                }
                
                
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        currentLocationButton
                    }
                    .padding(.bottom, 16)
                    
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Text("해품당 화덕생선구이")
                                .font(.pretendardBold20)
                                .padding(.bottom, 24)
                            
                            HStack(alignment: .bottom) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("구이")
                                    Text("화성시 오산동")
                                }
                                .font(.pretendardRegular14)
                                .foregroundStyle(.gray)
                                
                                Spacer()
                                
                                Button {
                                    print("길안내는 준비중 입니다")
                                } label: {
                                    HStack {
                                        Image(systemName: "location.fill")
                                        Text("161m")
                                    }
                                }
                                .font(.pretendardBold14)
                                .padding(8)
                                .foregroundStyle(.white)
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        VStack { // 아래 두 버튼 너비 같게
                            Button("더보기") {
                                // TODO: [] WebView 띄우기
                            }
                            .padding()
                            .frame(width: 88)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            Spacer()
                            Button("예약하기") {
                                // TODO: [] 전화 팝업 띄우기
                            }
                            .padding()
                            .frame(width: 88)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .font(.pretendardBold14)
                        .foregroundStyle(.white)
                    }
                    .frame(maxHeight: 128)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 24)
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
