//
//  AddRestaurantSheet.swift
//  BestEats
//
//  Created by BH on 2024/07/17.
//

import SwiftUI

struct AddRestaurantSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    @State var restaurantName: String = ""
    @State var menuName: String = ""
    @State var oneLiner: String = ""
    @State var rateType: Rate = .like
    
    var body: some View {
        VStack {
            CloseButton()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("맛집명")
                TextField(
                    "맛집을 입력해주세요",
                    text: $restaurantName
                )
                .textFieldStyle(.roundedBorder)
                .font(.pretendardMedium16)
                Text("메뉴명")
                TextField(
                    "메뉴를 입력해주세요",
                    text: $menuName
                )
                .textFieldStyle(.roundedBorder)
                .font(.pretendardMedium16)
                Text("한줄평")
                TextField(
                    "한줄평을 입력해주세요",
                    text: $oneLiner
                )
                .textFieldStyle(.roundedBorder)
                .font(.pretendardMedium16)
                Text("내평가")
                HStack {
                    ForEach(Rate.allCases) { rate in
                        Button(action: {
                            // TODO: [] 바인딩 처리하면 에러 ($rateType)
                            self.rateType = rate
                        }, label: {
                            Spacer()
                            Image(rateType == rate ? "\(rate.rawValue)Fill" : rate.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                            Spacer()
                        })
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .padding()
                .padding(.horizontal, 24)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.5), lineWidth: 1)
                }
            }
            .font(.pretendardBold18)
            .padding(.top, 32)
            
            Spacer()
            
            Button(action: {
                isValidToAdd(restaurantName, menuName, oneLiner, rateType)
                ? coreDataManager.addRestaurant(restaurantName, menuName, oneLiner, rateType)
                : showFillOutToast()
                dismiss()
            }, label: {
                Text("추가하기")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 54)
                    .background(.green)
                    .foregroundStyle(.white)
                    .font(.pretendardBold18)
                    .clipShape(Capsule())
            })
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }
    
    private func isValidToAdd(
        _ restaurantName: String,
        _ menuName: String,
        _ oneLiner: String,
        _ rateType: Rate
    ) -> Bool {
        guard !restaurantName.isEmpty, !menuName.isEmpty, !oneLiner.isEmpty else { return false }
        
        if rateType == .like {
            // TODO: [] 팝업
            
        }
        
        return true
    }
    
    private func showFillOutToast() {
        // TODO: [] 토스트 띄우기
    }
}

#Preview {
    AddRestaurantSheet()
}
