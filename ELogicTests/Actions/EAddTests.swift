//
//  ELogicTests.swift
//  ELogicTests
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import XCTest
@testable import ELogic

class EAddTests: XCTestCase {

    func testOneAddTwo() throws {
        // Given
        let e1 = E.Int(value: 1)
        let e2 = E.Int(value: 2)

        // When
        let addition = E.Add(left: e1, right: e2).eval()

        // Then

        guard let addition = addition as? E.Int else {
            XCTFail("addition of two E.Int must be E.Int")
            return
        }

        XCTAssertEqual(addition, e1 + e2)
    }

    func testUnparse() throws {
        XCTAssertEqual(42, E.Int(value: 42).unparse() as! Int)
    }

    func testOneAddTrueShouldFail() throws {
        // Given
        let e1 = E.Int(value: 1)
        let e2 = E.Bool(value: true)

        // When
        let addition = E.Add(left: e1, right: e2).eval()

        // Then
        guard let addition = addition as? E.Add else {
            XCTFail("addition of two different types must be E.Add")
            return
        }

        XCTAssertEqual((addition.left as? E.Int)?.value, e1.value)
        XCTAssertEqual((addition.right as? E.Bool)?.value, e2.value)
    }

    func testMultipleAdditions() throws {
        // Given
        let e1 = E.Int(value: 1)
        let e2 = E.Int(value: 2)
        let e3 = E.Int(value: 100)
        let addition = E.Add(left: e1, right: e2)

        // When
        let sum = E.Add(left: addition, right: e3).eval()

        // Then

        guard let addition = sum as? E.Int else {
            XCTFail("addition of two E.Int must be E.Int")
            return
        }

        XCTAssertEqual(addition, e1 + e2 + e3)
    }

    func testMultipleAdditionsWithBooleanShouldFail() throws {
        // Given
        let e1 = E.Int(value: 1)
        let e2 = E.Int(value: 2)
        let e3 = E.Int(value: 100)
        let addition = E.Add(left: e1, right: e2)
        let mBool = E.Bool(value: true)

        // When
        let sum = E.Add(left: addition, right: e3).eval()
        let sumWithBool = E.Add(left: sum, right: mBool).eval()
        // Then

        guard let addition = sumWithBool as? E.Add else {
            XCTFail("addition of two different types must be E.Add")
            return
        }

        XCTAssertEqual((addition.right as? E.Bool)?.value, mBool.value)

    }

    func testTrueAddTrue() throws {
        // Given
        let e1 = E.Bool(value: true)
        let e2 = E.Bool(value: true)

        // When
        let add = E.Add(left: e1, right: e2).eval()

        // Then
        guard let mBool = add as? E.Bool else {
            XCTFail("addition of two boolean must be boolean")
            return
        }

        XCTAssertEqual(mBool.value, e1.value || e2.value)
    }

    func testTrueAddFalse() throws {
        // Given
        let e1 = E.Bool(value: true)
        let e2 = E.Bool(value: false)

        // When
        let add = E.Add(left: e1, right: e2).eval()

        // Then
        guard let mBool = add as? E.Bool else {
            XCTFail("addition of two boolean must be boolean")
            return
        }

        XCTAssertEqual(mBool.value, e1.value || e2.value)
    }

    func testFalseAddTrue() throws {
        // Given
        let e1 = E.Bool(value: false)
        let e2 = E.Bool(value: true)

        // When
        let add = E.Add(left: e1, right: e2).eval()

        // Then
        guard let mBool = add as? E.Bool else {
            XCTFail("addition of two boolean must be boolean")
            return
        }

        XCTAssertEqual(mBool.value, e1.value || e2.value)
    }

    func testFalseAddFalse() throws {
        // Given
        let e1 = E.Bool(value: false)
        let e2 = E.Bool(value: false)

        // When
        let add = E.Add(left: e1, right: e2).eval()

        // Then
        guard let mBool = add as? E.Bool else {
            XCTFail("addition of two boolean must be boolean")
            return
        }

        XCTAssertEqual(mBool.value, e1.value || e2.value)
    }
}
