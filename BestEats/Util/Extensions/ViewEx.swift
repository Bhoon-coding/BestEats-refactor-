//
//  ViewEx.swift
//  BestEats
//
//  Created by BH on 2024/07/31.
//

import SwiftUI

import PopupView

extension View {
    
    func toast(toastManager: ToastManager) -> some View {
        self.popup(isPresented: Binding(
            get: { toastManager.isShowing },
            set: { toastManager.isShowing = $0 })
        ) {
            Text(toastManager.message)
                .frame(width: 240, height: 40)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .background(Color.gray.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 16))
        } customize: { popup in
            popup
                .type(.floater())
                .autohideIn(2)
        }
    }
    
    func favoriteAlert(
        isPresented: Binding<Bool>,
        completion: @escaping (Bool) -> Void
    ) -> some View {
        self.alert(
            "즐겨찾기 추가",
            isPresented: isPresented,
            actions: {
                Button("네") { completion(true) }
                Button("아니오", role: .cancel) { completion(false) }
            },
            message: {
                Text("즐겨찾기에 추가 하시겠습니까?")
            }
        )
    }
}
