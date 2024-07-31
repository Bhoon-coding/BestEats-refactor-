//
//  MenuAddView.swift
//  BestEats
//
//  Created by BH on 2024/07/30.
//

import SwiftUI

struct AddMenuSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    @State var menuName: String = ""
    @State var oneLiner: String = ""
    @Binding var rateType: Rate
    
    var restaurant: Restaurant
    
    private var isValid: Bool { !menuName.isEmpty && !oneLiner.isEmpty }
    
    var body: some View {
        VStack {
            CloseButton()
            
            VStack(alignment: .leading, spacing: 16) {
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
                ? addMenu(name: menuName, oneLiner: oneLiner, rateType: rateType)
                : showFillOutToast()
            }, label: { AddText() })
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }
    
    private func addMenu(name: String, oneLiner: String, rateType: Rate) {
        coreDataManager.addMenu(with: self.restaurant, menuName, oneLiner, rateType)
        dismiss()
    }
    
    private func showFillOutToast() {
        // TODO: [] 토스트 띄우기
    }
}

#Preview {
    @State var rateType: Rate = .curious
    
    return AddMenuSheet(rateType: $rateType, restaurant: Restaurant())
}
