// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum BestEatsAsset: Sendable {
  public static let appLogo = BestEatsImages(name: "AppLogo")
  public static let background = BestEatsColors(name: "background")
  public static let commonBlack = BestEatsColors(name: "commonBlack")
  public static let commonGreen = BestEatsColors(name: "commonGreen")
  public static let commonOrange = BestEatsColors(name: "commonOrange")
  public static let commonRed = BestEatsColors(name: "commonRed")
  public static let commonWhite = BestEatsColors(name: "commonWhite")
  public static let asian = BestEatsImages(name: "asian")
  public static let barbecue = BestEatsImages(name: "barbecue")
  public static let cafe = BestEatsImages(name: "cafe")
  public static let chicken = BestEatsImages(name: "chicken")
  public static let chinese = BestEatsImages(name: "chinese")
  public static let dessert = BestEatsImages(name: "dessert")
  public static let hamburger = BestEatsImages(name: "hamburger")
  public static let japanese = BestEatsImages(name: "japanese")
  public static let korean = BestEatsImages(name: "korean")
  public static let pizza = BestEatsImages(name: "pizza")
  public static let salad = BestEatsImages(name: "salad")
  public static let western = BestEatsImages(name: "western")
  public static let searchFoods = BestEatsImages(name: "searchFoods")
  public static let searchFoodsSelected = BestEatsImages(name: "searchFoodsSelected")
  public static let close = BestEatsImages(name: "close")
  public static let foodsTable = BestEatsImages(name: "foodsTable")
  public static let cafeClip = BestEatsImages(name: "cafeClip")
  public static let currentLocation = BestEatsImages(name: "currentLocation")
  public static let restaurantClip = BestEatsImages(name: "restaurantClip")
  public static let curious2 = BestEatsImages(name: "curious2")
  public static let curiousFill2 = BestEatsImages(name: "curiousFill2")
  public static let like2 = BestEatsImages(name: "like2")
  public static let likeFill2 = BestEatsImages(name: "likeFill2")
  public static let warning2 = BestEatsImages(name: "warning2")
  public static let warningFill2 = BestEatsImages(name: "warningFill2")
  public static let bad = BestEatsImages(name: "bad")
  public static let badFill = BestEatsImages(name: "badFill")
  public static let curious = BestEatsImages(name: "curious")
  public static let curiousFill = BestEatsImages(name: "curiousFill")
  public static let like = BestEatsImages(name: "like")
  public static let likeFill = BestEatsImages(name: "likeFill")
  public static let star = BestEatsImages(name: "star")
  public static let starFill = BestEatsImages(name: "starFill")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class BestEatsColors: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public var color: Color {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIColor: SwiftUI.Color {
      return SwiftUI.Color(asset: self)
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension BestEatsColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: BestEatsColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: BestEatsColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct BestEatsImages: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: BestEatsImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: BestEatsImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: BestEatsImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
