//
//  HomeView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            
        }
        .searchable(text: $searchText, prompt: "맛집을 검색해주세요")
    }
}

#Preview {
    HomeView()
}
