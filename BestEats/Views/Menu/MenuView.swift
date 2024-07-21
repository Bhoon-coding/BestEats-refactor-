//
//  MenuView.swift
//  BestEats
//
//  Created by BH on 2024/07/19.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var restaurant: Restaurant
    @State var rateType: Rate = Rate.like
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 16) {
                    ForEach(Rate.allCases) { rate in
                        Button(action: {
                            self.rateType = rate
                        }, label: {
                            Text(
                                rate.rawValue == "like"
                                 ? "좋아요"
                                 : rate.rawValue == "curious"
                                 ? "먹어볼래요"
                                 : "별로에요"
                            )
                                .font(.pretendardBold16)
                                .foregroundStyle(
                                    rate.rawValue == self.rateType.rawValue ? .white : .black
                                )
                        })
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(rate.rawValue == self.rateType.rawValue ? .green : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            
            // 메뉴 (List 사용)
//            let filteredMenu =
//            List(restaurant.MenuList) { menu in
//                 $rateType
//                VStack {
//                    HStack {
//                        
//                    }
//                }
//            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.1))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(restaurant.wrappedName)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                })
            }
        }
    }
}

#Preview {
    let context = StoreDataManager.shared.container.viewContext
    let restaurant = Restaurant(context: context)
    restaurant.id = UUID()
    restaurant.name = "아웃백"
    
    return MenuView(restaurant: restaurant)
}
