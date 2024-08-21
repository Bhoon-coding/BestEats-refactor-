//
//  ImageEx.swift
//  BestEats
//
//  Created by BH on 2024/07/18.
//

import Foundation

public enum Img {
    static let logo = "AppLogo"
    static let like = "like"
    static let likeFill = "likeFill"
    static let curious = "curious"
    static let curiousFill = "curiousFill"
    static let bad = "bad"
    static let badFill = "badFill"
    static let star = "star"
    static let starFill = "starFill"
    static let close = "close"
    static let more = "ellipsis"
    static let back = "chevron.left"
    static let add = "plus"
    static let house = "house.fill"
    static let map = "map"
    static let setting = "gearshape.fill"
    static let currentLocation = "currentLocation"
    
    enum Map {
        enum Clip {
            static let cafe = "cafeClip"
            static let restaurant = "restaurantClip"
            static let arrowPoint = "arrowtriangle.down.fill"
        }
    }
    
    enum FoodCategory {
        static let cafe = "cafe"
        static let korean = "korean"
        static let japanese = "japanese"
        static let chinese = "chinese"
        static let western = "western"
        static let dessert = "dessert"
        static let barbecue = "barbecue"
        static let chicken = "chicken"
        static let pizza = "pizza"
        static let asian = "asian"
        static let hamburger = "hamburger"
        static let salad = "salad"
    }
}
