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
        ZStack {
            Button {
                self.isPresented.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("맛집 추가")
                }
                .font(.pretendardBold18)
                .foregroundStyle(.gray)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
                )
            }
            .padding(.vertical, 40)
            .sheet(
                isPresented: $isPresented,
                content: { AddRestaurantSheet() }
            )
        }
        .frame(maxWidth: .infinity)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 24)
        .shadow(radius: 4, x: 8, y: 8)
    }
}
