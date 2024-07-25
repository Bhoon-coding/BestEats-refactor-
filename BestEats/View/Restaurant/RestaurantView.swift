//
//  RestaurantView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

struct RestaurantView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var coreDataManager: CoreDataManager
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(coreDataManager.savedRestaurant) { item in
                    NavigationLink {
                        MenuView(restaurant: item)
                    } label: {
                        RestaurantCardView(restaurant: item)
                            .padding(.horizontal, 24)
                            .shadow(radius: 4, x: 8, y: 8)
                            .padding(.bottom, 16)
                    }
                }
                AddRestaurantCard()
            }
            .background(.gray.opacity(0.1))
            .navigationBarBackButtonHidden(true)
            .searchable(text: $searchText, prompt: "맛집을 검색해주세요")
        }
    }
}

#Preview {
    RestaurantView()
        .environmentObject(CoreDataManager())
}


