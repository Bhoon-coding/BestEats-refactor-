//
//  PlaceMapView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI
import MapKit

struct PlaceMapView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = PlaceMapViewModel()
    @State private var isPresentedSheet: Bool = false
    @State var foodType: FoodType = .cafe
    
    var body: some View {
        NavigationStack {
        ZStack {
            map
            
            VStack {
                topContentContainer
                Spacer()
                bottomContentContainer
            }
            .padding(.horizontal)
            .padding(.vertical, 24)
        }
    }
        .onAppear {
            vm.getCurrentLocation()
            self.isPresentedSheet = true
        }
        .onChange(of: vm.place) { newPlace in
            zoomToLocation(location: newPlace!.coordinate)
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
    
    // MARK: - Function
    
//    private func setInfoNearPlaceCount() -> String {
//        let placeCount: Int = vm.placeList.count
//        return "근처에 \(placeCount)개의 맛집이 있어요!"
//    }
//    
//    private func setPlaceName() -> String {
//        guard let place = selectedPlace else {
//            return self.nearestPlace?.placeName ?? PlaceInfoError.emptyData.messageDescription
//        }
//        return place.placeName
//    }
//    
//    private func setCategoryName() -> String {
//        
//        guard let place = selectedPlace,
//              let categoryName = place.categoryName else {
//            return self.nearestPlace?.categoryName ?? PlaceInfoError.emptyData.messageDescription
//        }
//        return categoryName
//    }
//    
//    private func setAddressName() -> String {
//        guard let place = selectedPlace,
//              let roadAddress = place.roadAddressName else {
//            return self.nearestPlace?.roadAddressName ?? PlaceInfoError.emptyData.messageDescription
//        }
//        return place.addressName ?? roadAddress
//    }
//    
//    private func setDistance() -> String {
//        var distance: String?
//        
//        if let place = selectedPlace {
//            distance = place.distance
//        } else {
//            distance = nearestPlace?.distance
//        }
//        
//        guard let validDistance = distance,
//              let distanceValue = Double(validDistance) else {
//            return PlaceInfoError.emptyData.messageDescription
//        }
//        
//        return distanceValue.convertedDistance()
//    }
//    
    private func zoomToLocation(location: CLLocationCoordinate2D) {
        withAnimation(.easeIn) {
            vm.region.center = location
        }
    }
}

// MARK: - View

extension PlaceMapView {
    
    private var map: some View {
        Map(
            coordinateRegion: $vm.region,
            showsUserLocation: true,
            //                userTrackingMode: .constant(.follow),
            annotationItems: vm.placeList
        ) { nearPlace in
            MapAnnotation(coordinate: nearPlace.coordinate) {
                CustomMapMarkerView(
                    selectedPlace: $vm.place,
                    place: nearPlace,
                    type: foodType
                )
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private var topContentContainer: some View {
        ZStack {
            searchedPlaceText // 가운데로 두기 위함
            
            HStack {
                Spacer()
                menuButton
            }
        }
    }
    
    private var searchedPlaceText: some View {
        Text(vm.setInfoNearPlaceCount())
            .font(.pretendardBold14)
            .foregroundStyle(.white)
            .padding()
            .background(.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var menuButton: some View {
        Button(action: {
            self.isPresentedSheet = true
        }, label: {
            Image(systemName: Img.Map.Icons.menu)
                .font(.pretendardBold18)
        })
        .frame(width: 48, height: 48)
        .foregroundStyle(.white)
        .background(.green)
        .clipShape(Circle())
    }
    
    private var bottomContentContainer: some View {
        VStack(spacing: 16) {
            currentLocationContainer
            placeInfoAndButtonContainer
        }
    }
    
    private var currentLocationContainer: some View {
        HStack {
            Spacer()
            currentLocationButton
        }
    }
    
    private var currentLocationButton: some View {
        Button(action: {
            vm.getCurrentLocation()
        }, label: {
            Image(Img.currentLocation)
                .resizable()
                .frame(width: 24, height: 24)
        })
        .padding()
        .background(.green)
        .clipShape(Circle())
    }
    
    private var placeInfoAndButtonContainer: some View {
        HStack(spacing: 16) {
            placeInfoContainer
//            if $vm.selectedPlace != nil || $vm.nearestPlace != nil {
            // TODO: [] 확인 필요
                placeInfoButtonContainer
//            }
        }
        .frame(maxHeight: 128)
    }
    
    private var placeInfoContainer: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(vm.setPlaceName())
                .font(.pretendardBold20)
            
            HStack(alignment: .bottom) {
                placeInfoContents
                Spacer()
                placeDistanceButton
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var placeInfoContents: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(vm.setCategoryName())
            Text(vm.setAddressName())
        }
        .font(.pretendardRegular14)
        .foregroundStyle(.gray)
    }
    
    private var placeDistanceButton: some View {
        Button {
            // TODO: [] 길안내 준비중 팝업
            print("길안내는 준비중 입니다")
        } label: {
            HStack {
                Image(systemName: Img.Map.Icons.location)
                Text(vm.setDistance())
            }
        }
        .font(.pretendardBold14)
        .padding(8)
        .foregroundStyle(.white)
        .background(.green)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var placeInfoButtonContainer: some View {
        VStack {
            NavigationLink {
                ReuseWebView(
                    placeName: vm.place?.placeName ?? "",
                    urlString: vm.place?.placeURL ?? ""
                )
            } label: {
                Text(ETC.Button.more)
                    .padding()
                    .frame(width: 88)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Spacer()
            
            Button(PlaceMap.Button.reserve) {
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
}

#Preview {
    @State var type: FoodType = .cafe
    return PlaceMapView()
}
