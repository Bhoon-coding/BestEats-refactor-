//
//  MenuDetailView.swift
//  BestEats
//
//  Created by BH on 2024/07/22.
//

import SwiftUI

struct MenuDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coreDataManager: CoreDataManager
    @EnvironmentObject var toastManager: ToastManager
    @Binding var rateType: Rate
    
    @State var name: String
    @State var oneLiner: String
    @State var isEditMode: Bool = false
    @State var isFavorite: Bool = false
    @State var showFavoriteAlert: Bool = false
    @State var toastText: String = ""
    
    var restaurant: Restaurant
    var menu: Menu?
    
    private var toolBarButton: some View {
        Button(isEditMode ? "저장" : "수정") { isEditMode ? checkValid() : handleEdit() }
        .font(.pretendardBold18)
        .foregroundStyle(.black)
    }
    
    init(rateType: Binding<Rate>, restaurant: Restaurant, menu: Menu? = nil) {
        self._rateType = rateType
        self.restaurant = restaurant
        self.menu = menu
        self._name = State(initialValue: menu?.wrappedName ?? "")
        self._oneLiner = State(initialValue: menu?.wrappedOneLiner ?? "")
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("메뉴명")
                TextField(
                    "메뉴를 입력해주세요",
                    text: $name
                )
                .disabled(!isEditMode)
                .textFieldStyle(.roundedBorder)
                .font(.pretendardMedium16)
                Text("한줄평")
                TextField(
                    "한줄평을 입력해주세요",
                    text: $oneLiner
                )
                .disabled(!isEditMode)
                .textFieldStyle(.roundedBorder)
                .font(.pretendardMedium16)
                Text("내평가")
                HStack {
                    ForEach(Rate.allCases) { rate in
                        Button(action: {
                            self.rateType = rate
                        }, label: {
                            Spacer()
                            Image(rateType == rate ? "\(rate.rawValue)Fill" : rate.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                            Spacer()
                        })
                        .disabled(!isEditMode)
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
            }
            .font(.pretendardBold18)
            .padding(24)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { BackButton() }
                ToolbarItem { toolBarButton }
            }
            Spacer()
        }
        .toast(toastManager: toastManager)
    }
    
    
    private func checkValid() {
        if name.isEmpty || oneLiner.isEmpty {
            showFillOutToast()
        } else {
            handleSaveAction()
        }
    }
    
    private func showFillOutToast() {
        self.toastText = name.isEmpty ? "메뉴명을 입력해주세요" : "한줄평을 입력해주세요"
        toastManager.showToast(message: toastText)
    }
    
    private func handleSaveAction() {
        rateType == .like
        : handleSave(isFavorite: false)
    }
    
    private func handleEdit() {
        self.isEditMode.toggle()
    }
    
    private func handleSave(isFavorite: Bool) {
        coreDataManager.updateMenu(
            with: restaurant,
            id: menu?.id ?? UUID(),
            name: name,
            oneLiner: oneLiner,
            rate: rateType.rawValue,
            isFavorite: isFavorite
        )
        dismiss()
    }
}

#Preview {
    
    @State var rateType: Rate = .like
    let context = CoreDataManager().context
    let restaurant = Restaurant(context: context)
    let menu = Menu(context: context)
    restaurant.id = UUID()
    restaurant.name = "스벅"
    
    menu.id = UUID()
    menu.isFavorite = false
    menu.name = "아아"
    menu.oneLiner = "soso"
    menu.rate = Rate.like.rawValue
    
    menu.restaurant = restaurant
    
    let menu2 = Menu(context: context)
    menu2.id = UUID()
    menu2.isFavorite = true
    menu2.name = "자허블"
    menu2.oneLiner = "good"
    menu2.rate = Rate.like.rawValue
    
    menu2.restaurant = restaurant
    
    return MenuDetailView(rateType: $rateType, restaurant: restaurant, menu: menu)
        .environmentObject(ToastManager())
}
