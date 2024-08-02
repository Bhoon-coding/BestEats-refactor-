//
//  AddRestaurantCard.swift
//  BestEats
//
//  Created by BH on 2024/07/19.
//

import SwiftUI

struct AddRestaurantCard: View {
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            self.isPresented = true
        }, label: {
            Image(systemName: "plus")
                .font(.pretendardBold24)
                .padding()
                .background(.green)
                .foregroundStyle(.white)
                .clipShape(Circle())
                .shadow(radius: 4, x: 0, y: 4)
        })
        .padding()
        .sheet(
            isPresented: $isPresented,
            content: { AddRestaurantSheet() }
        )
    }
}
