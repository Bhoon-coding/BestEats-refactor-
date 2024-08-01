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
    
    var filteredData: [Restaurant] {
        if searchText.isEmpty {
            return coreDataManager.savedRestaurant
        } else {
            return coreDataManager.savedRestaurant.filter { $0.wrappedName.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(filteredData) { item in
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
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "맛집을 검색해주세요"
            )
        }
    }
}

#Preview {
    RestaurantView()
        .environmentObject(CoreDataManager())
}


