//
//  RecommendationView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import CoreLocation
import SwiftUI

import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    @Binding var isUserTracking: Bool
    @Binding var location: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer()
        view.sizeToFit()
        context.coordinator.createController(view)
        context.coordinator.controller?.prepareEngine()
        
        return view
    }
    
    func updateUIView(_ uiView: KMViewContainer, context: Context) {
        DispatchQueue.main.async {
            // 현재 위치 표시
            if isUserTracking {
                if let location = location {
                    context.coordinator.updateMapLocation(location: location)
                    isUserTracking = false
                } else {
                    print("location을 찾을 수 없음")
                }
            }
            
            if draw {
                if context.coordinator.controller?.isEnginePrepared == false {
                    context.coordinator.controller?.prepareEngine()
                }
                
                if context.coordinator.controller?.isEngineActive == false {
                    context.coordinator.controller?.activateEngine()
                }
            } else {
                context.coordinator.controller?.pauseEngine()
                context.coordinator.controller?.resetEngine()
            }
        }
        
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator()
    }
    
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        // 현재 UIView 삭제 및 초기화
    }
    
    class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        
        override init() {
            first = true
            auth = false // TODO: - 여기두면 계속 초기화 되지않나??
            super.init()
        }
        
        func createController(_ view: KMViewContainer) {
            container  = view
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
//        
        func authenticationFailed(_ errorCode: Int, desc: String) {
            print("error code: \(errorCode)")
            print("\(desc)")
            print("retryCount: \(retryCount)")
            
            if retryCount < 3 {
                controller?.prepareEngine() // 인증 재시도
            } else {
                // TODO: [] 권한 실패 알림 팝업
                retryCount = 0
            }
        }
        
        func addViews() {
            // TODO: [] 앱 켰을때 위도/경도 넣어야함 (현재위치 표시필요)
            var defaultPosition: MapPoint
            if let location = currentLocation {
                defaultPosition = MapPoint(longitude: location.longitude, latitude: location.latitude)
            } else {
                defaultPosition = MapPoint(longitude: 127.12769650456, latitude: 37.166902045045)
            }
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)

            controller?.addView(mapviewInfo)
//            let defaultPosition: MapPoint = MapPoint(longitude: 126.978365, latitude: 37.566691)
        }
        
        func updateMapLocation(location: CLLocationCoordinate2D) {
//            let msg = controller?.getStateDescMessage()
//            print("msg: \(msg)")
            currentLocation = location
            if let mapView = controller?.getView("mapview") as? KakaoMap {
                let mapPoint = MapPoint(longitude: location.longitude, latitude: location.latitude)
                // TODO: [] 현재 zoomLevel도 가져와 보여주기
                let cameraUpdate = CameraUpdate.make(target: mapPoint, mapView: mapView)
                mapView.moveCamera(cameraUpdate)
            }
        }
        
        func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            print("OK")
            let view = controller?.getView("mapview")
            view?.viewRect = container!.bounds
        }
        
        func containerDidResized(_ size: CGSize) { // TODO: [] 뭐하는앤지 알아보기
            let mapView = controller?.getView("mapview") as? KakaoMap
            mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
            
            if first {
                let initialPosition = currentLocation ?? CLLocationCoordinate2D(latitude: 36.166902045045, longitude: 127.12769650456)
                let mapPoint: MapPoint = .init(longitude: initialPosition.longitude, latitude: initialPosition.latitude)
                let cameraUpdate = CameraUpdate.make(target: mapPoint, zoomLevel: 15, mapView: mapView!)
                mapView?.moveCamera(cameraUpdate)
                first = false
            }
        }
        
        func addViewFailed(_ viewName: String, viewInfoName: String) {
            print(#function, "Failed")
        }
        
        func authenticationSucceeded() {
            auth = true
        }
        
        @AppStorage(UserStorage.locationAuth) private var auth: Bool = false
        var controller: KMController?
        var container: KMViewContainer?
        var first: Bool
        var retryCount: Int = 0
        var currentLocation: CLLocationCoordinate2D?
    }
}
