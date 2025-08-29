//
//  PulseAIUITests.swift
//  PulseAIUITests
//
//  Created by Meet Brahmbhatt on 29/08/25.
//

import XCTest

final class PulseAIUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        if app.state != .runningForeground {
            app.launch()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
    }

    func testInvalidEmailLogin() {
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]

        emailField.tap()
        emailField.typeText("invalid_email")

        passwordField.tap()
        passwordField.typeText("SomePassword123")

        app.buttons["Login"].tap()

        let errorMessage = app.staticTexts["Please enter a valid email address"]
        XCTAssertTrue(errorMessage.exists)
    }

    func testLoginFlow() throws {

        let emailField = app.textFields["Email"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("miit@gmail.com")

        let passwordField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5))
        passwordField.tap()
        passwordField.typeText("Test@1234")

        app.keyboards.buttons["return"].tap()

        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5))
        loginButton.tap()

        let homeScreen = app.staticTexts["Home Screen"]
        XCTAssertTrue(homeScreen.waitForExistence(timeout: 10))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    func clearAndTypeText(_ text: String) {
        tap()
        guard let stringValue = self.value as? String else {
            typeText(text)
            return
        }

        // delete existing text
        let deleteString = stringValue.map { _ in XCUIKeyboardKey.delete.rawValue }.joined()
        typeText(deleteString)

        // type new text
        typeText(text)
    }
}
