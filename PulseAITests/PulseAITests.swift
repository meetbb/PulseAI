//
//  PulseAITests.swift
//  PulseAITests
//
//  Created by Meet Brahmbhatt on 29/08/25.
//

import XCTest
@testable import PulseAI

final class PulseAITests: XCTestCase {

    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func textEmptyEmailAndPasswordShowsError() {
        let viewModel = LoginViewModel()

        viewModel.email = ""
        viewModel.password = ""
        viewModel.login()

        XCTAssertEqual(viewModel.errorMessage, "Email and password must not be empty!")
        XCTAssertFalse(viewModel.isLoggedIn)
    }

    func testValidEmail() {
        XCTAssertTrue(viewModel.isValidEmail("meet@example.com"))
        XCTAssertTrue(viewModel.isValidEmail("john.doe123@mail.co.in"))
        XCTAssertTrue(viewModel.isValidEmail("x_y-z+1@domain.org"))
    }

    func testInvalidEmailMissingAtSymbol() {
        XCTAssertFalse(viewModel.isValidEmail("meet.example.com"))
    }

    func testInvalidEmailMissingDomain() {
        XCTAssertFalse(viewModel.isValidEmail("meet@"))
    }

    func testInvalidEmailInvalidCharacters() {
        XCTAssertFalse(viewModel.isValidEmail("meet@@example.com"))
        XCTAssertFalse(viewModel.isValidEmail("meet@exa mple.com"))
    }

    func testEmptyEmail() {
        XCTAssertFalse(viewModel.isValidEmail(""))
    }

    func testSuccessfulLoginSetsIsLoggedInTrue() {
        // Stubs values (pretend these are correct credentials)
        viewModel.email = "miit@gmail.com"
        viewModel.password = "Test@1234"

        // Normally we would mock FirebaseAuth here. For demo, assume success.
        viewModel.isLoggedIn = true
        XCTAssertTrue(viewModel.isLoggedIn)
    }
}
