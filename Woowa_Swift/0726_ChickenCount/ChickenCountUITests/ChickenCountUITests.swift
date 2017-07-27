//
//  ChickenCountUITests.swift
//  ChickenCountUITests
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
@testable import ChickenCount

class ChickenCountUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        let textField = app.textFields["4자리 이상"]
        textField.tap()
        textField.typeText("lmj")
        
        let secureTextField = app.secureTextFields["6자리 이상"]
        secureTextField.typeText("ing")
        secureTextField.tap()
        
        let secureTextField2 = app.secureTextFields["비밀번호 확인"]
        secureTextField2.typeText("123456")
        secureTextField2.tap()
        secureTextField2.typeText("123")
        app.typeText("456")
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        XCUIDevice.shared().orientation = .portrait
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
