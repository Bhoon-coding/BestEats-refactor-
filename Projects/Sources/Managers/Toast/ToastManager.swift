//
//  ToastManager.swift
//  BestEats
//
//  Created by BH on 2024/07/31.
//

import SwiftUI

import PopupView

final class ToastManager: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var message: String = ""
    
    func showToast(message: String) {
        self.message = message
        self.isShowing = true
    }
}
