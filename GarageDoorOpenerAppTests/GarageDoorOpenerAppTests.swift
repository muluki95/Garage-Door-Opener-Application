//
//  GarageDoorOpenerAppTests.swift
//  GarageDoorOpenerAppTests
//
//  Created by Esther Nzomo on 5/2/25.
//

//import Testing
import XCTest
@testable import GarageDoorOpenerApp

//struct GarageDoorOpenerAppTests {

    //@Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
class GarageDoorOpenerAppTests: XCTestCase {
    func testGarageStatusDataDecoding() throws {
       //Sample JSON string
        let json = """
    {
     "garage" : {
         "isOpen": true,
         "notifications": []
    },
    "notifications" : [
       {
        "title": "Door Opened",
        "message" : "The garage door was opened",
        "timestamp" : "2025-05-01T14:23:00Z"

        }
     ]
    
     }
    """
        let jsonData = Data(json.utf8)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do{
            let decoded = try decoder.decode(GarageStatusData.self, from : jsonData)
            
            XCTAssertTrue (decoded.garage.isOpen)
            XCTAssertEqual(decoded.notifications.count, 1)
            XCTAssertEqual(decoded.notifications.first? .title, "Door Opened")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }

}
}
