//
//  CloseButton.swift
//  BestEats
//
//  Created by BH on 2024/07/18.
//

import SwiftUI

struct CloseButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Image(Img.close)
                    .resizable()
                    .frame(width: 16, height: 16)
            })
        }
    }
}

#Preview {
    CloseButton()
}
