//
//  StringEx.swift
//  BestEats
//
//  Created by BH on 2024/08/05.
//

extension String {
    func trimming() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}

// MARK: - Namespace

public enum Tab {
    static let home: String = "홈"
    static let recommend: String = "추천"
    static let setting: String = "설정"
}

public enum Navigation {
    enum Title {
        static let appName: String = "BestEats"
    }
    enum Button {
        static let save: String = "저장"
        static let update: String = "수정"
    }
}

public enum Alerts {
    enum Title {
        enum Restaurant {
            static let setting: String = "맛집 설정"
            static let update: String = "맛집명 변경"
            static let delete: String = "맛집 삭제"
        }
        
        static let addFavorite: String = "즐겨찾기 추가"
    }
    
    enum Button {
        static let update: String = "변경"
        static let delete: String = "삭제"
        static let confirm: String = "확인"
        static let cancel: String = "취소"
    }
    
    enum Message {
        enum Restaurant {
            static let update: String = "맛집이름을 변경해주세요"
            static let delete: String = "맛집에 포함된 메뉴들도 삭제 됩니다\n 삭제하시겠습니까?"
        }
        
        static let selectBelow: String = "아래 항목을 선택해주세요"
        static let addFavorite: String = "즐겨찾기에 추가 하시겠습니까?"
    }
}

public enum Info {
    enum Label {
        static let restaurant: String = "맛집명"
        static let menu: String = "메뉴명"
        static let oneLiner: String = "한줄평"
        static let rating: String = "내 평가"
    }
    
    enum Placeholder {
        static let searchRestaurant: String = "맛집을 검색해주세요"
        static let needRestaurantName: String = "맛집을 입력해주세요"
        static let needMenuName: String = "메뉴를 입력해주세요"
        static let needOneLiner: String = "한줄평을 입력해주세요 (30자 이내)"
    }
    
    enum RateDescription {
        static let like: String = "좋아요"
        static let curious: String = "먹어볼래요"
        static let bad: String = "별로에요"
    }
    
    static let favoriteMenuSuggestion: String = "즐겨찾는 메뉴를 추가해보세요 😆"
}

public enum ETC {
    enum Button {
        static let add: String = "추가하기"
    }
}
