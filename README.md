# Besteats

> 배만 채우면 되던 시대는 이제 옛날 얘기!!

어떻게 먹어야 맛있게 먹을수 있을까를 고민하는 시대. <br>

기록하고 나만의 레시피로 맛있게 먹자🍗

  

<br>

## 목차
1. [프로젝트 소개](#프로젝트-소개)
    - 기능 소개
2. 객체 역할 소개
      - 앱 설계
      - View
      - Manager
3. 고민한점

<br><br>

  


## 프로젝트 소개

### 👨‍💻 Developer
|이병훈 (1인 개발)|
|:--:|

<br>

### 이런분들에게 추천합니다!

  

- 음식점 마다 나에게 맞는 간이나 매운맛의 강도가 다 다르지 않았나?

- 오랜만에 방문한 맛집. 어떻게 먹어야 맛있었지? 다음엔 이걸 먹어봐야겠다고 했는데 그게 뭐였지?

- 일식이나 중식이 땡기는데 근처 맛집이 어딨지?

<br>
  

### Skills

- SwiftUI
- Swift Concurrency
- MVVM
- CoreData
- CLLocation
- MapKit
- UnitTest

  

<br>


### Tools

- Xcode(v15.2)
- SPM(Swift Package Manager)


<br>

### Version Target

- iOS 16.0

<br>

  

## 기능소개

  

## Main page (개인 맛집 기록)

<img width = "30%" src = "https://github.com/user-attachments/assets/7d9d49d8-e219-4ba4-980d-0a81146e5a28">

  

<br>

  

### 맛집 티켓 (Grid)
- LazyVGrid를 활용하여 사용자가 등록한 맛집들을 한눈에 볼 수 있도록 구현함

  

<br>

  

### CRUD

- `CoreData`를 사용하여 맛집 추가, 불러오기, 변경, 삭제 기능을 구현하여 로컬 데이터를 관리함
- CoreDataManager로 CoreData관련 로직만 담당하도록 구현하여 테스트를 용이하게 하였으며, 의존성을 분리 시킴

|Create <br> 맛집, 메뉴 등록|Update, Delete <br>맛집 변경 & 삭제
|:--:|:--:|
|<img width= "40%" src = "https://github.com/user-attachments/assets/f1818719-f310-47de-88d9-0ccfb1b25097">|<img width= "60%" src = "https://github.com/user-attachments/assets/d733033f-f119-41e9-9f9f-ab164d86d051">|



<br><br>

#### Create ([링크](https://github.com/Bhoon-coding/BestEats_refactor/blob/bcf96f7d84150aeff5cf34a91098eb708c7ce5d3/BestEats/Managers/CoreData/CoreDataManager.swift#L30C1-L72C6))


<details> 
<summary> 소스코드 </summary>
    
```swift 
// MARK: - Add
    
    func addRestaurant(
        _ restaurantName: String,
        _ menuName: String,
        _ oneLiner: String,
        _ rateType: Rate,
        _ isFavorite: Bool
    ) {
        let newRestaurant = Restaurant(context: context)
        let newMenu = Menu(context: context)
        
        newRestaurant.id = UUID()
        newRestaurant.name = restaurantName
        
        newMenu.id = UUID()
        newMenu.name = menuName
        newMenu.oneLiner = oneLiner
        newMenu.rate = rateType.rawValue
        newMenu.restaurant = newRestaurant
        newMenu.isFavorite = isFavorite
        
        saveContext()
    }
    
    func addMenu(
        with restaurant: Restaurant,
        _ name: String,
        _ oneLiner: String,
        _ rateType: Rate,
        _ isFavorite: Bool
    ) {
        let newMenu = Menu(context: context)
        
        newMenu.id = UUID()
        newMenu.name = name
        newMenu.oneLiner = oneLiner
        newMenu.rate = rateType.rawValue
        newMenu.isFavorite = isFavorite
        newMenu.restaurant = restaurant
        
        fetchMenu(with: restaurant, rateType)
    }

```
    

</details>





#### Read ([링크](https://github.com/Bhoon-coding/BestEats_refactor/blob/bcf96f7d84150aeff5cf34a91098eb708c7ce5d3/BestEats/Managers/CoreData/CoreDataManager.swift#L126))

<details>
<summary>소스코드</summary>
    
```swift
    
init() {
        self.container = NSPersistentContainer(name: "RestaurantList")
        self.container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error: \(error), \(error.localizedDescription)")
            }
        }
        self.context = self.container.viewContext
        fetchRestaurant() // 초기화시 데이터 fetch
    }
    
private func fetchRestaurant() {
        let request = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        do {
            self.savedRestaurant = try context.fetch(request)
        } catch {
            print("Fetch Error: \(error.localizedDescription)")
        }
    }
    
    func fetchMenu(with restaurant: Restaurant, _ type: Rate) {
        let sortedMenu: [Menu] = restaurant.MenuList.sorted(by: { $0.wrappedName < $1.wrappedName })
        self.filteredMenu = sortedMenu.filter { $0.rate == type.rawValue }
    }
```
</details>

#### Update ([링크](https://github.com/Bhoon-coding/BestEats_refactor/blob/bcf96f7d84150aeff5cf34a91098eb708c7ce5d3/BestEats/Managers/CoreData/CoreDataManager.swift#L74-L103))
<details>
<summary>소스코드</summary>
    
```swift
    
    // MARK: - Update
    
    func updateRestaurant(with restaurant: Restaurant, newName: String? = nil) {
        if let newName = newName {
            restaurant.name = newName
            saveContext()
        }
    }
    
    func updateMenu(
        with restaurant: Restaurant,
        id menuId: UUID,
        name menuName: String,
        oneLiner menuOneLiner: String,
        rate menuRate: String,
        isFavorite: Bool = false
    ) {
        guard let menuSet = restaurant.menu as? Set<Menu> else {
            print("No menu in restaurant")
            return
        }
        
        if let menu = menuSet.first(where: { $0.id == menuId }) {
            menu.name = menuName
            menu.oneLiner = menuOneLiner
            menu.rate = menuRate
            menu.isFavorite = isFavorite
            saveContext()
        }
    }
```
</details>

#### Delete ([링크](https://github.com/Bhoon-coding/BestEats_refactor/blob/bcf96f7d84150aeff5cf34a91098eb708c7ce5d3/BestEats/Managers/CoreData/CoreDataManager.swift#L105-L110))
    
<details>
<summary>소스코드</summary>
    
```swift
    // MARK: - Delete
    
    func delete(with object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
```
</details>


  

<br>

  

### 맛집 찾기

 <img width= "30%" src = "https://github.com/user-attachments/assets/ad5525b5-9ee8-40aa-9b8e-e8503e65ea5a">

  

- 등록되어 있는 음식점을 `filter`, `contain` 메소드를 이용해서 사용자가 찾고자 하는 음식점을 직관적으로 추려내게 구현
    
<br><br>

  
## 근처 맛집 (MapView)
    
- MapKit을 이용해 지도를 활용함
- CLLocation으로 현위치 좌표, 목적지까지 남은거리를 구해오도록 구현함
- 선택된 카테고리에 따라 근처 맛집 검색결과를 보여주도록 구현
    

    

    

<br>

  

#### 해당 맛집 메뉴타입별 숫자 보여주기

- 등록된 맛집의 메뉴 타입별로 메뉴갯수를 나타내게 하였습니다.

  

<br>

  

#### Empty State (CollectionView, TableView)

- 데이터가 없을시 빈 화면이 아닌 맛집 데이터 추가를 유도하는 View를 보여주도록 하였습니다.


<br>

  

## MenuList page (메뉴리스트 페이지)

<img width="30%" src = "https://user-images.githubusercontent.com/64088377/168582735-dc804477-5649-42ce-b5cf-0795892bda57.png">

  

- TableView를 사용하여 등록한 `메뉴`와 `한줄팁`을 보기쉽게 구현 하였습니다.

- Main page에서 받아온 데이터를 navigation title, tableViewCell에 보여주도록 하였습니다.

- `좋아요`, `먹어볼래요`, `별로에요` 버튼 클릭시 `filter 메소드`를 사용하여 타입별로 나타내게 하였습니다.

-> 위 타입별로 filter 하게되면 index를 가져오는데 어려움이있어 Model 구조를 변경 하였습니다.

- `좋아요` 타입에서 ⭐️ 터치시 메인페이지에 등록된 메뉴가 보이도록 즐겨찾기 기능 구현 하였습니다.

  

<br>



## MenuAdd page (메뉴 추가 페이지)

  

- 메뉴 추가시 `해당 맛집`에 추가 되게 구현 하였습니다.
- UserDefaults를 활용하여 사용자가 등록한 맛집들을 로컬에 저장하게 하였습니다.

  

<br>

  
## MenuDetail page (메뉴 상세 페이지)

<img width="30%" src = "https://user-images.githubusercontent.com/64088377/169181539-1ce587dd-3cf3-41ee-a01a-0d96385c44da.gif">

  

- 메뉴 리스트의 선택된 cell의 데이터를 가져와서 보여주게 하였습니다.

- 우측 상단 navItem에 `수정`, `저장` 버튼에 따라 이벤트를 주게 하였습니다. (수정모드 <-> 변경내용저장)

- 타입(`좋아요`, `먹어볼래요`, `별로에요`)이 수정전 타입과 다르게 변경되면 `menuList페이지` 에서도 수정된 타입으로 메뉴가 이동하게 구현 하였습니다.



<br>

## Git Branch

  

`<Prefix>/<구현내용>(<#이슈번호>)` 의 양식에 따라 브랜치 명을 작성합니다.

  

  

### 1. prefix

- `main`: 개발이 완료되어 최종 배포될 브랜치
- `develop`: default branch - feat, fix등 구현된 기능들이 merge된 후 main에 merge 되기 전 관리될 브랜치
- `feat`: 기능을 개발하는 브랜치
- `fix`: 버그를 수정하는 브랜치

  

### ⚠️ 참고

- 띄어쓰기 부분은 '-' 을 사용합니다.
- branch 내용은 '소문자 영어'로만 작성합니다.


### 예시

  

``` swift

fix/restaurant_page(#10)

feat/serach_restaurant(#8)

```

  

## Commit Message Convention

  

### 1. 기본 형식

```swift

// 아래 구분마다 띄워쓰기 해주며, [이슈내용] 부분에 띄어쓰기시 그대로 띄워줍니다.

[prefix]: [이슈내용](#이슈번호)

  

```

  

### 2. 예시

  

```swift

feat: 맛집 검색기능 구현(#12)

```

## Code Convention

https://github.com/StyleShare/swift-style-guide 을 최대한 따르고 있습니다.
