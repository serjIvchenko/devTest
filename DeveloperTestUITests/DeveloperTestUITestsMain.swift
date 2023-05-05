//
//  DeveloperTestUITestsMain.swift
//  DeveloperTestUITests
//
//  Created by sergey ivchenko on 04.05.2023.
//

import XCTest

final class DeveloperTestUITestsMain: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    let app = XCUIApplication()
    
    func testGeneral() throws {
        app.launch()
        let image1 = app.images["ImageCache1"]
        print(app)
        XCTAssert(image1.waitForExistence(timeout: 5))
        image1.swipeUp(velocity: 1000)
        let image6 = app.images["ImageCache6"]
        XCTAssert(image6.exists)
        let movieTile6 = app.staticTexts["MovieCellTitle6"]
        movieTile6.tap()
        let imagesDetails = app.images["MovieDetailsImage6"]
        XCTAssert(imagesDetails.exists)
    }
}
