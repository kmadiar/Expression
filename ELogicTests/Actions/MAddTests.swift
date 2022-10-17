//
//  ELogicTests.swift
//  ELogicTests
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import XCTest
@testable import ELogic

class MAddTests: XCTestCase {

    func testOneAddTwo() throws {
        // Given
        let e1 = MInt(value: 1)
        let e2 = MInt(value: 2)

        // When
        let addition = MAdd(left: e1, right: e2).eval()

        // Then

        guard let addition = addition as? MInt else {
            XCTFail("addition of two MInt must be MInt")
            return
        }

        XCTAssertEqual(addition, e1 + e2)
    }

    func testUnparse() throws {
        XCTAssertEqual(42, MInt(value: 42).unparse() as! Int)
    }

    func testOneAddTrueShouldFail() throws {
        // Given
        let e1 = MInt(value: 1)
        let e2 = MBool(value: true)

        // When
        let addition = MAdd(left: e1, right: e2).eval()

        // Then
        guard let addition = addition as? MAdd else {
            XCTFail("addition of two different types must be MAdd")
            return
        }

        XCTAssertEqual((addition.left as? MInt)?.value, e1.value)
        XCTAssertEqual((addition.right as? MBool)?.value, e2.value)
    }

    func testMultipleAdditions() throws {
        // Given
        let e1 = MInt(value: 1)
        let e2 = MInt(value: 2)
        let e3 = MInt(value: 100)
        let addition = MAdd(left: e1, right: e2)

        // When
        let sum = MAdd(left: addition, right: e3).eval()

        // Then

        guard let addition = sum as? MInt else {
            XCTFail("addition of two MInt must be MInt")
            return
        }

        XCTAssertEqual(addition, e1 + e2 + e3)
    }

    func testMultipleAdditionsWithBooleanShouldFail() throws {
        // Given
        let e1 = MInt(value: 1)
        let e2 = MInt(value: 2)
        let e3 = MInt(value: 100)
        let addition = MAdd(left: e1, right: e2)
        let mBool = MBool(value: true)

        // When
        let sum = MAdd(left: addition, right: e3).eval()
        let sumWithBool = MAdd(left: sum, right: mBool).eval()
        // Then

        guard let addition = sumWithBool as? MAdd else {
            XCTFail("addition of two different types must be MAdd")
            return
        }

        XCTAssertEqual((addition.right as? MBool)?.value, mBool.value)

    }

    func testTrueAddTrue() throws {
        // Given
        let e1 = MBool(value: true)
        let e2 = MBool(value: true)

        // When
        let add = MAdd(left: e1, right: e2).eval()

        // Then
        guard let mBool = add as? MBool else {
            XCTFail("addition of two boolean must be boolean")
            return
        }

        XCTAssertEqual(mBool.value, e1.value || e2.value)
    }

    func testTrueAddFalse() throws {
        // Given
        let e1 = MBool(value: true)
        let e2 = MBool(value: false)

        // When
        let add = MAdd(left: e1, right: e2).eval()

        // Then
        guard let mBool = add as? MBool else {
            XCTFail("addition of two boolean must be boolean")
            return
        }

        XCTAssertEqual(mBool.value, e1.value || e2.value)
    }

    func testFalseAddTrue() throws {
        // Given
        let e1 = MBool(value: false)
        let e2 = MBool(value: true)

        // When
        let add = MAdd(left: e1, right: e2).eval()

        // Then
        guard let mBool = add as? MBool else {
            XCTFail("addition of two boolean must be boolean")
            return
        }

        XCTAssertEqual(mBool.value, e1.value || e2.value)
    }

    func testFalseAddFalse() throws {
        // Given
        let e1 = MBool(value: false)
        let e2 = MBool(value: false)

        // When
        let add = MAdd(left: e1, right: e2).eval()

        // Then
        guard let mBool = add as? MBool else {
            XCTFail("addition of two boolean must be boolean")
            return
        }

        XCTAssertEqual(mBool.value, e1.value || e2.value)
    }
}
