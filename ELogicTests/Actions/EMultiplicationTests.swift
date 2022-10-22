//
//  MMultiplicationTests.swift
//  ELogicTests
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import XCTest
@testable import ELogic

class MultiplicationTests: XCTestCase {

    func testOneMultipliedByTwo() throws {
        // Given
        let e1 = E.Int(value: 1)
        let e2 = E.Int(value: 2)

        // When
        let multiplication = E.Multiplication(left: e1, right: e2).eval()

        // Then

        guard let multiplication = multiplication as? E.Int else {
            XCTFail("multiplication of two E.Int must be E.Int")
            return
        }

        XCTAssertEqual(multiplication, e1 * e2)
    }

    func testOneMultipliedByBoolean() throws {
        // Given
        let e1 = E.Int(value: 1)
        let e2 = E.Bool(value: true)

        // When
        let multiplication = E.Multiplication(left: e1, right: e2).eval()

        // Then

        guard let multiplication = multiplication as? E.Multiplication else {
            XCTFail("multiplication of E.Int and E.Bool must be MMultiplication")
            return
        }

        XCTAssertEqual((multiplication.left as? E.Int)?.value, e1.value)
        XCTAssertEqual((multiplication.right as? E.Bool)?.value, e2.value)
    }

    func testOneAddHundredSuccess() throws {
        // Given
        let e1 = E.Int(value: 1)
        let e2 = E.Int(value: 2)
        let e3 = E.Int(value: 100)
        let addition = E.Multiplication(left: e1, right: e2)

        // When
        let multiplication = E.Multiplication(left: addition, right: e3).eval()


        // Then

        guard let multiplication = multiplication as? E.Int else {
            XCTFail("multiplication of two E.Int must be E.Int")
            return
        }

        XCTAssertEqual(multiplication, e1 * e2 * e3)
    }

    func testTrueMultipliedByTrue() throws {
        // Given
        let e1 = E.Bool(value: true)
        let e2 = E.Bool(value: true)

        // When
        let multiplication = E.Multiplication(left: e1, right: e2).eval()

        // Then
        guard let mBool = multiplication as? E.Bool else {
            XCTFail("multiplication of two E.Bool must be E.Bool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }

    func testTrueMultipliedByFalse() throws {
        // Given
        let e1 = E.Bool(value: true)
        let e2 = E.Bool(value: false)

        // When
        let multiplication = E.Multiplication(left: e1, right: e2).eval()

        // Then
        guard let mBool = multiplication as? E.Bool else {
            XCTFail("multiplication of two E.Bool must be E.Bool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }

    func testFalseMultipliedByTrue() throws {
        // Given
        let e1 = E.Bool(value: true)
        let e2 = E.Bool(value: true)

        // When
        let multiplication = E.Multiplication(left: e1, right: e2).eval()

        // Then
        guard let mBool = multiplication as? E.Bool else {
            XCTFail("multiplication of two E.Bool must be E.Bool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }

    func testFalseMultipliedByFalse() throws {
        // Given
        let e1 = E.Bool(value: true)
        let e2 = E.Bool(value: true)

        // When
        let multiplication = E.Multiplication(left: e1, right: e2).eval()

        // Then
        guard let mBool = multiplication as? E.Bool else {
            XCTFail("multiplication of two E.Bool must be E.Bool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }
}
