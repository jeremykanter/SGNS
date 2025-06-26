//
//  SGNSTests.swift
//  SGNSTests
//
//  Created by Jeremy Kanter on 6/6/25.
//

import Testing
import XCTest
@testable import SGNS

struct SGNSTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    func testMoonSign() {
        // Test with a known date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        // Test with a specific date
        let testDate = dateFormatter.date(from: "2024-03-20 12:00:00")!
        let moonSign = getMoonSign(from: testDate)
        
        print("Test date: \(testDate)")
        print("Moon sign: \(moonSign.rawValue)")
    }

}
