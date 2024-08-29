//
//  AddRestaurantCard.swift
//  BestEats
//
//  Created by BH on 2024/07/19.
//

import SwiftUI

struct AddButton: View {
    
    @State private var isPresented = false
    
    var sheet: AddSheetType
    
    enum AddSheetType {
        case restaurant
        case menu(rateType: Binding<Rate>, restaurant: Restaurant)
        
        @ViewBuilder
        var sheetView: some View {
            switch self {
            case .restaurant:
                AddRestaurantSheet()
            case .menu(let rateType, let restaurant):
                AddMenuSheet(rateType: rateType, restaurant: restaurant)
            }
        }
    }
    
    var body: some View {
        Button(action: {
            self.isPresented = true
        }, label: {
            Image(systemName: Img.add)
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
            content: { sheet.sheetView }
        )
    }
}
