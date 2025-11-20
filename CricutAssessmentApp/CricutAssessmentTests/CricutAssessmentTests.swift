//
//  CricutAssessmentTests.swift
//  CricutAssessmentTests
//
//  Created by KANNAN SHANMUGAM on 11/15/25.
//

import XCTest

class MockNetworkManager: NetworkingProtocol {
    var mockData: Data = Data()
    var mockResponse: URLResponse = HTTPURLResponse(
        url: URL(string:"https://test.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!
    
    func request(_ url: URL) async throws -> (Data, URLResponse) {
        return (mockData, mockResponse)
    }
}

class MockAPIService: PaletteServiceProtocol {
    var fetchDataCalled = false
    var result: Result<PaletteResponse, APIError> = .success(PaletteResponse(buttons: []))
    func fetchData() async throws -> Result<PaletteResponse, APIError> {
        fetchDataCalled = true
        return result
    }
}

class HomeViewModelTests: XCTestCase {
    @MainActor
    func testInitialState() async {
        let vm = HomeViewModel()
        XCTAssertTrue(vm.paletteItems.isEmpty)
        XCTAssertTrue(vm.drawItems.isEmpty)
    }

    @MainActor
    func testRemoveAll() async {
        let vm = HomeViewModel()
        vm.drawItems = [PaletteItem(name: "Circle", drawPath: .circle), PaletteItem(name: "Square", drawPath: .square)]
        vm.removeAll()
        XCTAssertTrue(vm.drawItems.isEmpty)
    }

    @MainActor
    func testRemoveLast() async {
        let vm = HomeViewModel()
        vm.drawItems = [
            PaletteItem(name: "Circle1", drawPath: .circle),
            PaletteItem(name: "Circle2", drawPath: .circle),
            PaletteItem(name: "Square", drawPath: .square)
        ]
        vm.removeLast(paletteAsset: .circle)
        XCTAssertEqual(vm.drawItems.count, 2)
        XCTAssertEqual(vm.drawItems[0].name, "Circle1")
        XCTAssertEqual(vm.drawItems[1].name, "Square")
    }

    @MainActor
    func testRemoveAllWithAsset() async {
        let vm = HomeViewModel()
        vm.drawItems = [
            PaletteItem(name: "Circle1", drawPath: .circle),
            PaletteItem(name: "Circle2", drawPath: .circle),
            PaletteItem(name: "Square", drawPath: .square)
        ]
        vm.removeAll(paletteAsset: .circle)
        XCTAssertEqual(vm.drawItems.count, 1)
        XCTAssertEqual(vm.drawItems[0].drawPath, .square)
    }

    @MainActor
    func testFetchData() async {
        let mockService = MockAPIService()
        let response = PaletteResponse(buttons: [PaletteItem(name: "Circle", drawPath: .circle)])
        mockService.result = .success(response)
        let vm = HomeViewModel(service: mockService)
        await vm.fetchData()
        XCTAssertTrue(mockService.fetchDataCalled)
        XCTAssertEqual(vm.paletteItems.count, 1, "paletteItems should have 1 item after fetch")
        if vm.paletteItems.count > 0 {
            XCTAssertEqual(vm.paletteItems[0].name, "Circle")
        } else {
            XCTFail("paletteItems is empty, cannot check name")
        }
    }
    
    func testMockNetworkManagerReturnsMockDataAndResponse() async throws {

        let mockManager = MockNetworkManager()
        let expectedData = "test".data(using: .utf8)!
        let expectedResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        mockManager.mockData = expectedData
        mockManager.mockResponse = expectedResponse

        let (data, response) = try await mockManager.request(URL(string: "https://any.com")!)

        XCTAssertEqual(data, expectedData)
        XCTAssertEqual(response.url, expectedResponse.url)
        XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, expectedResponse.statusCode)
    }
}
