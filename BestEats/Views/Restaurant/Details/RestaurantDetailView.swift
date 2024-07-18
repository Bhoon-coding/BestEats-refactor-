//
//  RestaurantDetailView.swift
//  BestEats
//
//  Created by BH on 2024/07/17.
//

import SwiftUI

enum Rate {
    case like
    case curious
    case warning
}

struct RestaurantDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var restaurantName: String = ""
    @State var menuName: String = ""
    @State var oneLiner: String = ""
    @State var rateType: Rate?
    
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
                    Button(action: {
                        $rateType.wrappedValue = .like
                    }, label: {
                        Image($rateType.wrappedValue == .like ? "likeFill" : "like")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        $rateType.wrappedValue = .curious
                    }, label: {
                        Image($rateType.wrappedValue == .curious ? "curiousFill" : "curious")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        $rateType.wrappedValue = .warning
                    }, label: {
                        Image($rateType.wrappedValue == .warning ? "warningFill" : "warning")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                    })
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
                // 데이터 추가
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
}

#Preview {
    RestaurantDetailView(
        restaurantName: "",
        menuName: "",
        oneLiner: "",
        rateType: nil
    )
}
