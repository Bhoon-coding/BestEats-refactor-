//
//  UIImageEx.swift
//  BestEats
//
//  Created by BH on 2024/08/09.
//

import UIKit.UIImage

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size)
            .image { _ in
                draw(in: CGRect(origin: .zero, size: size))
            }
    }
}
