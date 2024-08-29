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
            Alerts.Title.addFavorite,
            isPresented: isPresented,
            actions: {
                Button(Alerts.Button.confirm) { completion(true) }
                Button(Alerts.Button.cancel, role: .cancel) { completion(false) }
            },
            message: {
                Text(Alerts.Message.addFavorite)
            }
        )
    }
}
