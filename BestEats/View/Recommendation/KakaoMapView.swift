//
//  RecommendationView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @AppStorage(UserStorage.locationAuth) private var auth: Bool = false
    @Binding var draw: Bool
    
    func makeUIView(context: Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer()
        view.sizeToFit()
        context.coordinator.createController(view)
        context.coordinator.controller?.prepareEngine()
        
        return view
    }
    
    func updateUIView(_ uiView: KMViewContainer, context: Context) {
        if draw {
            context.coordinator.controller?.activateEngine()
        } else {
            context.coordinator.controller?.resetEngine()
        }
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator()
    }
    
    
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        // 현재 UIView 삭제 및 초기화
    }
    
    class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        var controller: KMController?
        
        var first: Bool
        var retryCount: Int = 0
        
        override init() {
            first = true
            super.init()
        }
        
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
//        func authenticationSucceeded() {
//            print("성공")
//        }
//        
//        func authenticationFailed(_ errorCode: Int, desc: String) {
//            print("error code: \(errorCode)")
//            print("\(desc)")
//            
//            controller?.prepareEngine() // 인증 재시도
//        }
        
        func addViews() {
            // TODO: [] 앱 켰을때 위도/경도 넣어야함 (현재위치 표시필요)
            let defaultPosition: MapPoint = MapPoint(longitude: 127.12769650456, latitude: 37.166902045045)
//            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", appName: "openmap", viewInfoName: "kakao_map", defaultPosition: defaultPosition)
            
            controller?.addView(mapviewInfo)
        }
        
        func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            print("OK")
            
        }
        
        func addViewFailed(_ viewName: String, viewInfoName: String) {
            print("Failed")
        }
        
        func containerDidResized(_ size: CGSize) {
            guard let mapView = controller?.getView("mapview") as? KakaoMap else {
                print("Map view not found")
                return
            }
            mapView.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
            
            if first {
                let cameraUpdate = CameraUpdate.make(target: MapPoint(longitude: 127.12769650456, latitude: 36.166902045045), zoomLevel: 10, mapView: mapView)
                mapView.moveCamera(cameraUpdate)
                first = false
            }
        }
    }
}
