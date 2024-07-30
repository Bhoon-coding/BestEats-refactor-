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
    @Binding var rateType: Rate
    
    @State var name: String
    @State var oneLiner: String
    @State var isEditMode: Bool = false
    @State var isFavorite: Bool = false
    @State var showFavoriteAlert: Bool = false
    
    var restaurant: Restaurant
    var menu: Menu
    
    init(rateType: Binding<Rate>, restaurant: Restaurant, menu: Menu) {
        self._rateType = rateType
        self.restaurant = restaurant
        self.menu = menu
        self._name = State(initialValue: menu.wrappedName)
        self._oneLiner = State(initialValue: menu.wrappedOneLiner)
    }
    
    var body: some View {
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
        .alert(
            "즐겨찾기 추가",
            isPresented: $showFavoriteAlert,
            actions: {
                Button("네") {
                    coreDataManager.updateMenu(
                        with: restaurant,
                        id: menu.id ?? UUID(),
                        name: name,
                        oneLiner: oneLiner,
                        rate: rateType.rawValue,
                        isFavorite: true
                    )
                    dismiss()
                }
                Button("아니오", role: .cancel) {
                    coreDataManager.updateMenu(
                        with: restaurant,
                        id: menu.id ?? UUID(),
                        name: name,
                        oneLiner: oneLiner,
                        rate: rateType.rawValue,
                        isFavorite: false
                    )
                    dismiss()
                }
            },
            message: {
                Text("즐겨찾기에 추가 하시겠습니까?")
            }
        )
        .font(.pretendardBold18)
        .padding(24)
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
            ToolbarItem {
                if isEditMode {
                    Button("저장") {
                        // TODO: [] isFavorite 적용 필요
                        
                        if rateType == .like {
                            // TODO: [] 즐겨찾기 팝업 띄우기
                            self.showFavoriteAlert.toggle()
                        } else {
                            coreDataManager.updateMenu(
                                with: restaurant,
                                id: menu.id ?? UUID(),
                                name: name,
                                oneLiner: oneLiner,
                                rate: rateType.rawValue,
                                isFavorite: false
                            )
                            dismiss()
                        }
                    }
                    .font(.pretendardBold18)
                    .foregroundStyle(.black)
                } else {
                    Button("수정") {
                        self.isEditMode.toggle()
                    }
                    .font(.pretendardBold18)
                    .foregroundStyle(.black)
                }
            }
        }
        
        // TODO: [] 뒤로 갔을 때 이전 rate값 그대로 보여주기
        
        Spacer()
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
}
