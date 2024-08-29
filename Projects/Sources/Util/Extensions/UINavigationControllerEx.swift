//
//  UINavigationControllerEx.swift
//  BestEats
//
//  Created by BH on 2024/08/05.
//

import UIKit.UINavigationController

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
