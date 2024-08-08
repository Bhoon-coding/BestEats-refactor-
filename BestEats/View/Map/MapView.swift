//
//  MapView.swift
//  BestEats
//
//  Created by BH on 2024/08/08.
//

import SwiftUI

struct MapView: View {
    
    @StateObject private var locationMangaer = LocationManager()
    
    @State var draw: Bool = true // 뷰의 appear 상태를 전달하기 위한 변수
    @State var isUserTracking: Bool = false
    
    var body: some View {
        ZStack {
            
            KakaoMapView(
                draw: $draw,
                isUserTracking: $isUserTracking,
                location: $locationMangaer.currentLocation
            )
                .ignoresSafeArea(edges: .all)
            VStack {
                // TODO: [] [상단] 돋보기 아이콘 => sheet 띄우기
                // TODO: [] [우하단] 현재 위치로 돌아오는 기능 구현 (버튼)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                            isUserTracking = true
                            locationMangaer.requestCurrentLocation()
                            
                        }, label: {
                            Image(Img.currentLocation)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(.white)
                                .foregroundColor(.blue)
                                .clipShape(Circle())
                        })
                    .shadow(color: .black, radius: 4, y: 1)
                    .padding(.trailing)
                }
                
                // TODO: [] [하단] 맛집명 | 주소 | 정보보기 (버튼) | 예약하기
            }
        }
        .onAppear { locationMangaer.checkLocationAuth() }
    }
    
}

#Preview {
    MapView()
}
