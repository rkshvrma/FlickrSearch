//
//  FlickrServiceTests.swift
//  SearchFlickerTests
//
//  Created by Room on 7/3/24.
//

@testable import SearchFlicker
import XCTest

final class FlickrServiceTests: XCTestCase {

    var sut: FlickrService?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FlickrService(session: MockSession())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testFlickrServiceSuccessfullyGetsFlickrResponse() {
        let expectation = XCTestExpectation(description: "Successfully fetches FlickrResponse")
        var fetchedItems: [FlickrItem] = []
        
        sut?.fetchImages(for: "successTest", completion: { result in
            switch result {
            case .success(let items):
                fetchedItems = items
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        })
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(fetchedItems.count, 20)
        XCTAssertEqual(fetchedItems.first?.title, "You Mean There\'s No Way Outta Here")
        XCTAssertEqual(fetchedItems.first?.author, "nobody@flickr.com (\"tomswift46 ( Hi Res Images for the asking)\")")
        XCTAssertEqual(fetchedItems.first?.description, " <p><a href=\"https://www.flickr.com/people/tomswift/\">tomswift46 ( Hi Res Images for the asking)</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/tomswift/53832106487/\" title=\"You Mean There&#039;s No Way Outta Here\"><img src=\"https://live.staticflickr.com/65535/53832106487_0c8ddba568_m.jpg\" width=\"210\" height=\"240\" alt=\"You Mean There&#039;s No Way Outta Here\" /></a></p> ")
        XCTAssertEqual(fetchedItems.first?.published, "2024-07-03T17:59:26Z")
    }
}
