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
        context.coordinator.currentLocation = location
        
        return view
    }
    
    func updateUIView(_ uiView: KMViewContainer, context: Context) {
        DispatchQueue.main.async {
            // 현재 위치 표시
            if isUserTracking {
                trackingUser(context: context)
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
    
    private func trackingUser(context: Context) {
        if let location = location {
            context.coordinator.updateMapLocation(location: location)
            isUserTracking = false
        } else {
            print("location을 찾을 수 없음")
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
            currentLocation = location
            first = true
            auth = false // TODO: - 여기두면 계속 초기화 되지않나??
            super.init()
        }
        
        func addCurrentLocationMarker(mapPoint: MapPoint) {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PositionPoiLayer")
            
            let poiOption = PoiOptions(styleID: "positionPoiStyle")
            poiOption.rank = 1
            poiOption.transformType = .decal
            
            guard let poi = layer?.addPoi(option: poiOption, at: mapPoint) else { return }

            poi.show()
        }
        
        func createPoiStyle() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            // 심볼을 지정.
            // 심볼의 anchor point(심볼이 배치될때의 위치 기준점)를 지정. 심볼의 좌상단을 기준으로 한 % 값.
//            let noti1 = PoiBadge(badgeID: "badge1", image: UIImage(systemName: "star.circle.fill"), offset: CGPoint(x: 0.9, y: 0.1), zOrder: 0)
            let iconStyle = PoiIconStyle(symbol: UIImage(systemName: "person.circle.fill")?.withTintColor(.green), transition: PoiTransition(entrance: TransitionType.scale, exit: TransitionType.scale))
            let currentPoiStyle = PerLevelPoiStyle(iconStyle: iconStyle, level: 0)  // 이 스타일이 적용되기 시작할 레벨.
            let poiStyle = PoiStyle(styleID: "positionPoiStyle", styles: [
                currentPoiStyle
            ])
            manager.addPoiStyle(poiStyle)
        }
        
        func createLabelLayer() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let positionLayerOption = LabelLayerOptions(layerID: "PositionPoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 0)
            let _ = manager.addLabelLayer(option: positionLayerOption)
            
            // TODO: [] 맛집 데이터로 받아온 poi는 LodPoi로 처리
        }
        
        func createPois() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let positionLayer = manager.getLabelLayer(layerID: "PositionPoiLayer")   // 생성한 POI를 추가할 레이어를 가져온다.
            let poiOption = PoiOptions(styleID: "positionPoiStyle") // 생성할 POI의 Option을 지정하기 위한 자료를 담는 클래스를 생성. 사용할 스타일의 ID를 지정한다.
            poiOption.rank = 1
            poiOption.transformType = .decal
//            poiOption.clickable = true // clickable 옵션을 true로 설정한다. default는 false로 설정되어있다.
            let position: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001)
            
            currentDicrectionPoi = positionLayer?.addPoi(option: poiOption, at: position)
        }
        
        func createWaveShape() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getShapeManager()
            let layer = manager.addShapeLayer(layerID: "shapeLayer", zOrder: 10001, passType: .route)
            
            let shapeStyle = PolygonStyle(styles: [
                PerLevelPolygonStyle(color: .green, level: 0)
            ])
            let shapeStyleSet = PolygonStyleSet(styleSetID: "shapeLevelStyle")
            shapeStyleSet.addStyle(shapeStyle)
            manager.addPolygonStyleSet(shapeStyleSet)
            
            let options = PolygonShapeOptions(shapeID: "waveShape", styleID: "shapeLevelStyle", zOrder: 1)
            let points = Primitives.getCirclePoints(radius: 10, numPoints: 90, cw: true)
            let polygon = Polygon(exteriorRing: points, hole: nil, styleIndex: 0)
            
            options.polygons.append(polygon)
            options.basePosition = MapPoint(longitude: 0, latitude: 0)
            
            let shape = layer?.addPolygonShape(options)
            self.currentDicrectionPoi?.shareTransformWithShape(shape!)
        }
        
        func createAndStartWaveAnimation() {
            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
            let manager = mapView?.getShapeManager()
            let layer = manager?.getShapeLayer(layerID: "shapeLayer")
            let shape = layer?.getPolygonShape(shapeID: "waveShape")
            let waveEffect = WaveAnimationEffect(datas: [
                WaveAnimationData(startAlpha: 0.8, endAlpha: 0.0, startRadius: 10.0, endRadius: 100.0, level: 0)
            ])
            waveEffect.hideAtStop = true
            waveEffect.interpolation = AnimationInterpolation(duration: 1000, method: .cubicOut)
            waveEffect.playCount = 5
            
            let animator = manager?.addShapeAnimator(animatorID: "circleWave", effect: waveEffect)
            animator?.addPolygonShape(shape!)
            animator?.start()
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
                print("authenticationFailed: \(retryCount)")
                retryCount = 0
            }
        }
        
        func addViews() {
            // TODO: [] 앱 켰을때 위도/경도 넣어야함 (현재위치 표시필요)
            var defaultPosition: MapPoint
            if let location = currentLocation {
                defaultPosition = MapPoint(longitude: location.longitude, latitude: location.latitude)
            } else {
                defaultPosition = MapPoint(longitude: 127.108678, latitude: 37.402001)
            }
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)

            controller?.addView(mapviewInfo)
//            let defaultPosition: MapPoint = MapPoint(longitude: 126.978365, latitude: 37.566691)
        }
        
        func updateMapLocation(location: CLLocationCoordinate2D) {
            currentLocation = location
            if let mapView = controller?.getView("mapview") as? KakaoMap {
                let mapPoint = MapPoint(longitude: location.longitude, latitude: location.latitude)
                
                if let existingPoi = getExistingPoi() {
                    existingPoi.moveAt(mapPoint, duration: 300)
                    createAndStartWaveAnimation()
                } else {
                    addCurrentLocationMarker(mapPoint: mapPoint)
                    createAndStartWaveAnimation()
                }
                let cameraUpdate = CameraUpdate.make(target: mapPoint, mapView: mapView)
                mapView.moveCamera(cameraUpdate)
            }
        }
        
        func getExistingPoi() -> Poi? {
            guard let mapView = controller?.getView("mapview") as? KakaoMap else { return nil }
            let manager = mapView.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PositionPoiLayer")
            
            return layer?.getAllPois()?.first
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
            
            createLabelLayer() // Poi 생성순서 (LabelLayer => Poi)
            createPoiStyle()
            createWaveShape()
//            createPois()
        }
        
        @AppStorage(UserStorage.locationAuth) private var auth: Bool = false
        var controller: KMController?
        var container: KMViewContainer?
        var first: Bool
        var retryCount: Int = 0
        var currentLocation: CLLocationCoordinate2D?
        var currentDicrectionPoi: Poi?
    }
}
