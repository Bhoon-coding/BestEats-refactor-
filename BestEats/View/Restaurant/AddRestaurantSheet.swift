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
    @EnvironmentObject var toastManager: ToastManager
    
    @State var restaurantName: String = ""
    @State var menuName: String = ""
    @State var oneLiner: String = ""
    @State var rateType: Rate = .like
    @State var toastText: String = ""
    @State var showFavoriteAlert: Bool = false
    
    private var isValid: Bool { !restaurantName.isEmpty && !menuName.isEmpty && !oneLiner.isEmpty }
    
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
                isValid
                ? handleAddAction()
                : checkEmptyForm()
                
            }, label: { AddText() }
            )
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .favoriteAlert(isPresented: $showFavoriteAlert) { isFavorite in
            addRestaurant(isFavorite: isFavorite)
        }
    }
    
    // MARK: - Private
    
    private func handleAddAction() {
        rateType == .like
        ? showFavoriteAlert = true
        : addRestaurant(isFavorite: false)
    }
    
    private func addRestaurant(isFavorite: Bool) {
        coreDataManager.addRestaurant(restaurantName, menuName, oneLiner, rateType, isFavorite)
        dismiss()
    }
    
    private func checkEmptyForm() {
        var toastText: String = ""
        
        if restaurantName.isEmpty {
            toastText = "맛집명을 입력해주세요"
        } else if menuName.isEmpty {
            toastText = "메뉴명을 입력해주세요"
        } else {
            toastText = "한줄평을 입력해주세요"
        }
        
        showFillOutToast(message: toastText)
    }
    
    private func showFillOutToast(message: String) {
        toastManager.showToast(message: message)
    }
}

#Preview {
    AddRestaurantSheet()
}
