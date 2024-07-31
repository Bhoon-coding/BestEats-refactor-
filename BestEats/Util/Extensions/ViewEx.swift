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
