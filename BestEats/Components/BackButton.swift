//
//  BackButton.swift
//  BestEats
//
//  Created by BH on 2024/07/30.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: { dismiss() }, label: {
            Image(systemName: Img.back)
                .foregroundStyle(.black)
                .font(.pretendardBold18)
        })
    }
}
