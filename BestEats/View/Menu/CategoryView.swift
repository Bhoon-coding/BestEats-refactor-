//
//  CategoryView.swift
//  BestEats
//
//  Created by BH on 2024/07/22.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Binding var rateType: Rate
    
    var restaurant: Restaurant
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(Rate.allCases) { rate in
                Button(action: {
                    self.rateType = rate
                    coreDataManager.fetchMenu(with: restaurant, rateType)
                }, label: {
                    Text(rateDescription(with: rate))
                    .font(.pretendardBold16)
                    .foregroundStyle(rate == rateType ? .white : .black)
                })
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(rate == rateType ? .green : .white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
    
    private func rateDescription(with rate: Rate) -> String {
        switch rate {
        case .like:
            return Info.RateDescription.like
        case .curious:
            return Info.RateDescription.curious
        case .bad:
            return Info.RateDescription.bad
        }
    }
}

#Preview {
    @State var rateType = Rate.like
    let context = CoreDataManager().container.viewContext
    let restaurant = Restaurant(context: context)
    restaurant.name = "Sample Restaurant"
    
    return CategoryView(rateType: $rateType, restaurant: restaurant)
}
