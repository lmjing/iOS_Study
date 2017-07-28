//
//  AddViewController.swift
//  0712_MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

/*
 언니 코드리뷰하다가 알게 된 점
 언니가 notification을 2개 쓰셨음, 근데 모델에서 그걸 받는 함수가 같음, 이런 경우
 dic형태로 key로 구분한 후 모델에서는 그냥 보내고 컨트롤러에서 어떤 케이스인지 판단 한 후 처리 할 것
 */
class AddViewController2: UIViewController {
    @IBOutlet var addFoodBtn: [UIButton]!
    @IBOutlet var addMoneyBtn: [UIButton]!

    @IBOutlet var capacityLabel: [UILabel]!
    @IBOutlet var foodImageView: [UIImageView]!
    @IBOutlet weak var moneyLabel: UILabel!

    @IBOutlet var menuListView: [UITableView]!

    let center = NotificationCenter.default
    let nc = Notification.Name("NotificationIdentifier2")
//    var vendingMachine2 = FoodVendingMachine2.instance
    var vendingMachine3 = FoodVendingMachine3.instance

    var purchaseImageXPoint = 40
    var purchaseImageFoodName: String?
    //var purchaseImageFoodMenu: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        for tableView in menuListView {
            tableView.delegate = self
            tableView.dataSource = self
        }

        initView()

        for btn in addMoneyBtn {
            btn.addTarget(self, action: #selector(pressAddMoney(_:)), for: .touchUpInside)
        }

        for btn in addFoodBtn {
            btn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
        }

        center.addObserver(self,
                           selector: #selector(catchNotification),
                           name: nc,
                           object: nil)
    }

    func initView() {
        let menuList = vendingMachine3.getAllCapcityList()
        for label in capacityLabel {
            if let capacity = menuList[label.tag] {
                label.text = String(capacity) + "개"
            } else {
                label.text = "0개"
            }
        }

        moneyLabel.text = "잔액 : " + String(vendingMachine3.balance) + "원"
        for (menu, _) in vendingMachine3.getBuyList() {
            viewPurchasedList(purchaseImageFoodMenu: menu)
        }

        for imageview in foodImageView {
            imageview.layer.cornerRadius = 10
            imageview.clipsToBounds = true
            imageview.layer.masksToBounds = true
            imageview.layer.borderWidth = 5
            imageview.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func viewPurchasedList(purchaseImageFoodMenu: Int) {
        if let imageview = makeImageView(x: purchaseImageXPoint, y: 575, purchaseImageFoodMenu: purchaseImageFoodMenu) {
            self.view.addSubview(imageview)
            purchaseImageXPoint += 50
        }
    }

    func makeImageView(x: Int, y: Int, purchaseImageFoodMenu: Int) -> UIView? {
//        if let menu = purchaseImageFoodMenu {
            var cardImage: UIImageView

            switch purchaseImageFoodMenu {
            case 1: cardImage = UIImageView(image: #imageLiteral(resourceName: "chiken"))
            case 2: cardImage = UIImageView(image: #imageLiteral(resourceName: "pizza"))
            case 3: cardImage = UIImageView(image: #imageLiteral(resourceName: "bossam"))
            case 4: cardImage = UIImageView(image: #imageLiteral(resourceName: "hambuger"))
            case 5: cardImage = UIImageView(image: #imageLiteral(resourceName: "dduck"))
            default: return nil
            }
            cardImage.frame = CGRect(x: x, y: y, width: 140, height: 100)

            return cardImage
//        } else {
//            return nil
//        }
    }

    func btnPressed(_ btn: UIButton) {

        var food: Food
        switch btn.tag {
        case 1:
            food = Chicken(restaurant: "굽네치킨", capacity: 5, price: 10000, name: "고추바사삭", manufacturingDate: Date(), bone: true)
        case 2:
            food = Pizza(restaurant: "피자헛", capacity: 20, price: 12000, name: "피자", manufacturingDate: Date(), cheeseCrust: true)
        case 3:
            food = Bossam(restaurant: "원할머니보쌈", capacity: 30, price: 13000, name: "보쌈정식", manufacturingDate: Date(), noodle: true)
        case 4:
            food = Hambuger(restaurant: "맥도날드", capacity: 40, price: 14000, name: "빅맥버거", manufacturingDate: Date())
        case 5:
            food = Dduckppokki(restaurant: "엽기떡볶이", capacity: 50, price: 15000, name: "엽떡", manufacturingDate: Date(), spicy: .high)

        default:
            food = Food()
        }

        vendingMachine3.add(restaurant: food.restaurant, food: food)
    }

    func pressAddMoney(_ btn: UIButton) {

        var balance: Int = 0
        switch btn.tag {
        case 1000: balance = vendingMachine3.add(money: 1000)
        case 5000: balance = vendingMachine3.add(money: 5000)
        default:
            print("error!!!!!!")
        }

        moneyLabel.text = "잔액 : " + String(balance) + "원"
        print("돈 추가 : " + String(vendingMachine3.balance))
    }

    func catchNotification(notification: Notification) {
        let menu = notification.userInfo?["menu"] as! Int
        let capacitylist = notification.userInfo?["capacitylist"] as! [Int:Int]
        let capacity = capacitylist[menu]!
        capacityLabel[menu - 1].text = String(describing: capacity) + "개"
        menuListView[menu - 1].reloadData()
    }
}

extension AddViewController2: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = vendingMachine3.menuDic[tableView.tag]?.count {
            print("section",count)
            return count
        }else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = vendingMachine3.menuDic[tableView.tag]![section].menu.count
        print("row",count)
        return vendingMachine3.menuDic[tableView.tag]![section].menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let restaurant = vendingMachine3.menuDic[tableView.tag]?[indexPath.section]

        cell.textLabel?.text = restaurant?.name
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 15)
        let price = restaurant?.menu[indexPath.row].price
        cell.detailTextLabel?.text = String(describing: price!)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return vendingMachine3.menuDic[tableView.tag]?[section].name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantName = vendingMachine3.menuDic[tableView.tag]?[indexPath.section].name
        let food = vendingMachine3.menuDic[tableView.tag]?[indexPath.section].menu[indexPath.row]
        
        let balance = vendingMachine3.buy(restaurant: restaurantName!, food: food!)
        if balance > 0 {
            moneyLabel.text = "잔액 : " + String(balance)
            viewPurchasedList(purchaseImageFoodMenu: (vendingMachine3.getMenuType(food: food!)?.rawValue)!)
        } else if balance == -2 {
            moneyLabel.text = "선택제품의 재고가 부족합니다."
        } else if balance == -1 {
            moneyLabel.text = "잔액이 부족합니다."
        } else {
            print("type error")
        }
    }
}
