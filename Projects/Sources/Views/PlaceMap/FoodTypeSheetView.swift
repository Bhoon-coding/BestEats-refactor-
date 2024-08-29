//
//  FoodTypeSheetView.swift
//  BestEats
//
//  Created by BH on 2024/08/20.
//

import SwiftUI

struct FoodTypeSheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var foodType: FoodType
    
    let rows = [
        GridItem(.fixed(80), spacing: 24),
        GridItem(.fixed(80), spacing: 24),
        GridItem(.fixed(80), spacing: 24),
    ]
    
    var body: some View {
        VStack {
            LazyHGrid(rows: rows, alignment: .top, spacing: 32) {
                ForEach(FoodType.allCases, id: \.self) { item in
                    
                    if item != .none {
                        Button(action: {
                            foodType = item
                            dismiss()
                        }, label: {
                            VStack(spacing: 8) {
                                Image(item.imageName)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text(item.rawValue)
                                    .font(.pretendardBold16)
                                    .foregroundStyle(.black)
                            }
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding(.vertical, 80)
    }
}

#Preview {
    @State var foodType: FoodType = .cafe
    return FoodTypeSheetView(foodType: $foodType)
}
