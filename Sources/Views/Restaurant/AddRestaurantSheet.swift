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
    
    private var isValid: Bool {
        !restaurantName.trimming().isEmpty &&
        !menuName.trimming().isEmpty &&
        !oneLiner.trimming().isEmpty &&
        oneLiner.trimming().count <= 30
    }
    
    var body: some View {
        VStack {
            CloseButton()
            
            VStack(alignment: .leading, spacing: 16) {
                Text(Info.Label.restaurant)
                TextField(
                    Info.Placeholder.needRestaurantName,
                    text: $restaurantName
                )
                .textFieldStyle(.roundedBorder)
                .font(.pretendardMedium16)
                Text(Info.Label.menu)
                TextField(
                    Info.Placeholder.needMenuName,
                    text: $menuName
                )
                .textFieldStyle(.roundedBorder)
                .font(.pretendardMedium16)
                Text(Info.Label.oneLiner)
                TextField(
                    Info.Placeholder.needOneLiner,
                    text: $oneLiner
                )
                .textFieldStyle(.roundedBorder)
                .font(.pretendardMedium16)
                Text(Info.Label.rating)
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
        .toast(toastManager: toastManager)
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
        let restaurantName = self.restaurantName.trimming()
        let menuName = self.menuName.trimming()
        let oneLiner = self.oneLiner.trimming()
        
        coreDataManager.addRestaurant(restaurantName, menuName, oneLiner, rateType, isFavorite)
        dismiss()
    }
    
    private func checkEmptyForm() {
        var toastText: String = ""
        
        if restaurantName.trimming().isEmpty {
            toastText = Info.Placeholder.needRestaurantName
        } else if menuName.trimming().isEmpty {
            toastText = Info.Placeholder.needMenuName
        } else {
            toastText = Info.Placeholder.needOneLiner
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
