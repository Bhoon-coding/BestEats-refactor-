import ProjectDescription

private let appName: String = "BestEats"
private let bundleId: String = "com.bhooncoding.Besteats"
private let appVersion: String = "2.0.0"
private let bundleVersion: String = "2"
private let infoPlist: [String: Plist.Value] = [
    "UILaunchScreen": [
        "UIColorName": "",
        "UIImageName": "",
    ],
    "CFBundleShorVersionString": "\(appVersion)",
    "CFBundleVersion": "\(bundleVersion)",
    "UIUserInterfaceStyle": "Light",
    "KAKAO_API_KEY": "7072eb0a506b5f651bf1ad06d6f4db81",
    "KAKAO_SERVER_HOST": "${KAKAO_SERVER_HOST}"
]

let project = Project(
    name: appName,
    targets: [
        .target(
            name: appName,
            destinations: .iOS,
            product: .app,
            bundleId: bundleId,
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "Alamofire"),
                .external(name: "PopupView")
            ],
            settings: configureSettings()
            // MARK: - CoreData 아래처럼 하면 Default template 에러가 남
            /// 경로 다음과 같이 변경 Resources/CoreData/{모델명.xcdatamodeld}
//            coreDataModels: [
//                .coreDataModel("CoreData/RestaurantList.xcdatamodeld")
//            ]
        ),
        .target(
            name: "BestEatsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.bhooncoding.BesteatsTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "BestEats")]
        ),
    ],
    resourceSynthesizers: [
        .assets(),
        .fonts(),
//        .coreData()
    ]
)

private func configureSettings() -> Settings {
    .settings(
        base: [
            "DEVELOPMENT_TEAM": "R4G74AF442",
            "KAKAO_SERVER_HOST": "https://dapi.kakao.com"
        ],
        configurations: makeConfigurations(),
        defaultSettings: .recommended
    )
}

private func makeConfigurations() -> [Configuration] {
    let debug: Configuration = .debug(name: "Debug", xcconfig: "Configs/Debug.xcconfig")
    let release: Configuration = .release(name: "Release", xcconfig: "Configs/Release.xcconfig")
    
    return [debug, release]
}

//private func configureInfoPlist(merging other: [String: Plist.Value] = [:]) -> InfoPlist {
//    var extendedPlist: [String: Plist.Value] = [
//                "UILaunchScreen": [
//                    "UIColorName": "",
//                    "UIImageName": "",
//                ],
//                "CFBundleShorVersionString": "\(appVersion)",
//                "CFBundleVersion": "\(bundleVersion)",
//                "Appearance": "Light",
//                "KAKAO_API_KEY": "7072eb0a506b5f651bf1ad06d6f4db81",
//                "KAKAO_SERVER_HOST": "${KAKAO_SERVER_HOST}"
//            ]
//    
//    other.forEach { (key: String, value: Plist.Value) in
//        extendedPlist[key] = value
//    }
//    return InfoPlist.extendingDefault(with: extendedPlist)
//}
