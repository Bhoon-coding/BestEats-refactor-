//
//  CustomMapMarkerView.swift
//  BestEats
//
//  Created by BH on 2024/08/16.
//

import SwiftUI

struct CustomMapMarkerView: View {

    @Binding var selectedId: UUID?
    
    let restaurant: V2.Local.Search.Keyword.Response.RestaurantInfo
    let type: FoodType
    
    var body: some View {
        
        Button(action: {
            /// 1. 선택된 음식점 정보 보여주기 RestaurantMapView에서 정보를 받아 보여주기
            self.selectedId = restaurant.id
        }, label: {
            VStack {
                Image(type == .cafe || type == .dessert ? Img.Map.Clip.cafe : Img.Map.Clip.restaurant)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: self.selectedId == restaurant.id ? 64 : 32, height: self.selectedId == restaurant.id ? 64 : 32)
                
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
    @State var selectedId: UUID? = nil
    let restaurant = V2.Local.Search.Keyword.Response.RestaurantInfo(
        categoryGroupCode: "CE7",
        categoryGroupName: "카페",
        categoryName: "커피전문점",
        distance: "121",
        phone: "031-378-1980",
        placeName: "메가MGC커피 동탄산척점",
        placeURL: "http://place.map.kakao.com/1590183741",
        roadAddressName: "경기 화성시 동탄순환대로 263",
        addressName: "경기 화성시 산척동 723",
        x: "127.11873431706917",
        y: "37.17119905864608"
    )
    return CustomMapMarkerView(selectedId: $selectedId, restaurant: restaurant, type: .western)
}
