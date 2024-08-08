//
//  MapView.swift
//  BestEats
//
//  Created by BH on 2024/08/08.
//

import SwiftUI

struct MapView: View {
    
    @State var draw: Bool = true // 뷰의 appear 상태를 전달하기 위한 변수
    var body: some View {
        ZStack {
            KakaoMapView(draw: $draw)
            
        }
        
    }
    
}

#Preview {
    MapView()
}
