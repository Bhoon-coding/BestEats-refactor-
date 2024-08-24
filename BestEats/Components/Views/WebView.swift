//
//  WebView.swift
//  BestEats
//
//  Created by BH on 2024/08/23.
//

import SwiftUI
import WebKit

struct ReuseWebView: View {
    
    @State private var isLoading: Bool = true
    
    var placeName: String
    var urlString: String
    
    var body: some View {
            ZStack {
                WebView(isLoading: $isLoading, urlString: urlString)
                    
                if isLoading {
                    ProgressView()
                }
            }
    }
}

struct WebView: UIViewRepresentable {
    
    @Binding var isLoading: Bool
    let urlString: String
    
    // MARK: - Function
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.isLoading = false
            print("load 완료")
        }
    }
}

#Preview {
    let urlString = "http://place.map.kakao.com/1528748774"
    return ReuseWebView(placeName: "노브랜드버거", urlString: urlString)
}
