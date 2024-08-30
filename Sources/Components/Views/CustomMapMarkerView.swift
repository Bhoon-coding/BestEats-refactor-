//
//  CustomMapMarkerView.swift
//  BestEats
//
//  Created by BH on 2024/08/16.
//

import SwiftUI

struct CustomMapMarkerView: View {

    @Binding var selectedPlace: V2.Local.Search.Keyword.Response.PlaceInfo?
    
    let place: V2.Local.Search.Keyword.Response.PlaceInfo
    let type: FoodType
    
    var body: some View {
        
        Button(action: {
            self.selectedPlace = place
        }, label: {
            VStack {
                Image(type == .cafe || type == .dessert ? Img.Map.Clip.cafe : Img.Map.Clip.restaurant)
                    .resizable()
                    .clipShape(Circle())
                    .frame(
                        width: self.selectedPlace?.id == place.id ? 64 : 32,
                        height: self.selectedPlace?.id == place.id ? 64 : 32
                    )
                
                Image(systemName: Img.Map.Clip.arrowPoint)
                    .font(.caption)
                    .foregroundColor(.red)
                    .offset(x: 0, y: -5)
            }
            .frame(width: 32, height: 32)
        })
    }
}

#Preview {
    let restaurant = V2.Local.Search.Keyword.Response.PlaceInfo(
        placeName: "CE7",
        distance: "카페",
        categoryGroupCode: "커피전문점",
        categoryGroupName: "121",
        categoryName: "031-378-1980",
        phone: "메가MGC커피 동탄산척점",
        placeURL: "http://place.map.kakao.com/1590183741",
        roadAddressName: "경기 화성시 동탄순환대로 263",
        addressName: "경기 화성시 산척동 723",
        x: "127.11873431706917",
        y: "37.17119905864608"
    )
    @State var selectedPlace: V2.Local.Search.Keyword.Response.PlaceInfo? = restaurant
    
    return CustomMapMarkerView(
        selectedPlace: $selectedPlace,
        place: restaurant,
        type: .western
    )
}
