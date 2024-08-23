//
//  FoodType.swift
//  BestEats
//
//  Created by BH on 2024/08/20.
//

enum FoodType: String, CaseIterable {
    case korean = "한식"
    case japanese = "일식"
    case chinese = "중식"
    case western = "양식"
    case cafe = "카페"
    case dessert = "디저트"
    case barbecue = "구이"
    case chicken = "치킨"
    case pizza = "피자"
    case asian = "아시안"
    case hamburger = "햄버거"
    case salad = "샐러드"
    
    var imageName: String {
        switch self {
        case .korean:
            return Img.FoodCategory.korean
        case .japanese:
            return Img.FoodCategory.japanese
        case .chinese:
            return Img.FoodCategory.chinese
        case .western:
            return Img.FoodCategory.western
        case .cafe:
            return Img.FoodCategory.cafe
        case .dessert:
            return Img.FoodCategory.dessert
        case .barbecue:
            return Img.FoodCategory.barbecue
        case .chicken:
            return Img.FoodCategory.chicken
        case .pizza:
            return Img.FoodCategory.pizza
        case .asian:
            return Img.FoodCategory.asian
        case .hamburger:
            return Img.FoodCategory.hamburger
        case .salad:
            return Img.FoodCategory.salad
        }
    }
}
