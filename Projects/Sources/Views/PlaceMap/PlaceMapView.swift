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
    @State private var navPath = NavigationPath()
    @State private var isPresentedSheet: Bool = false
    @State var foodType: FoodType = .none
    
    var body: some View {
        Self._printChanges()
        return NavigationStack(path: $navPath) {
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
        .onChange(of: foodType ) { newFoodType in
            Task { await vm.fetchNearRestaurant(foodType: newFoodType) }
        }
        .onDisappear {
            navPath = .init()
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
            placeInfoButtonContainer
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
            routeToWebViewButton
            Spacer()
            makeCallButton
        }
        .font(.pretendardBold14)
        .foregroundStyle(.white)
    }
    
    private var routeToWebViewButton: some View {
        NavigationLink(value: vm.place) {
            Text(ETC.Button.more)
                .padding()
                .frame(width: 88)
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .navigationDestination(for: V2.Local.Search.Keyword.Response.PlaceInfo.self) { place in
            ReuseWebView(
                placeName: place.placeName,
                urlString: place.placeURL
            )
        }
    }
    
    private var makeCallButton: some View {
        Button(PlaceMap.Button.reserve) {
            vm.makeCall()
        }
        .padding()
        .frame(width: 88)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    @State var type: FoodType = .cafe
    return PlaceMapView()
}
