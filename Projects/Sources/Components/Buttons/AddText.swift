//
//  AddText.swift
//  BestEats
//
//  Created by BH on 2024/07/30.
//

import SwiftUI

struct AddText: View {
    var body: some View {
        Text("추가하기")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 54)
            .background(.green)
            .foregroundStyle(.white)
            .font(.pretendardBold18)
            .clipShape(Capsule())
    }
}

#Preview {
    AddText()
}
