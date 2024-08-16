//
//  CustomMapMarkerView.swift
//  BestEats
//
//  Created by BH on 2024/08/16.
//

import SwiftUI

struct CustomMapMarkerView: View {
    
    @State private var isTapped: Bool = false
    
    let name: String
    // TODO: [] 음식종류별 타입 지정
    let type: FoodType
    
    var body: some View {
        
        Button(action: {
            // TODO: [] isTapped 활성화가 되면 해야할것
            /// 1. 해당 마커 크기 크게 (id 값으로 비교할것 id가 아닌 경우는 일반사이즈)
            /// 2. 선택된 음식점 정보 보여주기 RestaurantMapView에서 정보를 받아 보여주기
            
            isTapped.toggle()
        }, label: {
            VStack {
    //            Image(type.rawValue)
                Image(systemName: "fork.knife.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                    .offset(x: 0, y: -5)
            }
            .frame(width: isTapped ? 32 : 16, height: isTapped ? 32 : 16)
        })
        
        
        
        
        
    }
}

enum FoodType: String {
    case cafe
    case korean
    case japanese
    case chinese
    case western
    case dessert
    // TODO: [] 음식종류 추가
}

#Preview {
    CustomMapMarkerView(name: "아웃백", type: .western)
}
