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
            Map(coordinateRegion: $vm.region, showsUserLocation: true)
                .ignoresSafeArea()
        }
    
    }
}

#Preview {
    RestaurantMapView()
        
}
