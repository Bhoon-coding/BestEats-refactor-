//
//  SplashView.swift
//  BestEats
//
//  Created by BH on 2024/08/01.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image(Img.logo)
            .resizable()
            .frame(width: 160, height: 160)
    }
}

#Preview {
    SplashView()
}
