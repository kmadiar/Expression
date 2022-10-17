//
//  MMultiplicationTests.swift
//  ELogicTests
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import XCTest
@testable import ELogic

class MMultiplicationTests: XCTestCase {

    func testOneMultipliedByTwo() throws {
        // Given
        let e1 = MInt(value: 1)
        let e2 = MInt(value: 2)

        // When
        let multiplication = MMultiplication(left: e1, right: e2).eval()

        // Then

        guard let multiplication = multiplication as? MInt else {
            XCTFail("multiplication of two MInt must be MInt")
            return
        }

        XCTAssertEqual(multiplication, e1 * e2)
    }

    func testOneMultipliedByBoolean() throws {
        // Given
        let e1 = MInt(value: 1)
        let e2 = MBool(value: true)

        // When
        let multiplication = MMultiplication(left: e1, right: e2).eval()

        // Then

        guard let multiplication = multiplication as? MMultiplication else {
            XCTFail("multiplication of MInt and MBool must be MMultiplication")
            return
        }

        XCTAssertEqual((multiplication.left as? MInt)?.value, e1.value)
        XCTAssertEqual((multiplication.right as? MBool)?.value, e2.value)
    }

    func testOneAddHundredSuccess() throws {
        // Given
        let e1 = MInt(value: 1)
        let e2 = MInt(value: 2)
        let e3 = MInt(value: 100)
        let addition = MMultiplication(left: e1, right: e2)

        // When
        let multiplication = MMultiplication(left: addition, right: e3).eval()


        // Then

        guard let multiplication = multiplication as? MInt else {
            XCTFail("multiplication of two MInt must be MInt")
            return
        }

        XCTAssertEqual(multiplication, e1 * e2 * e3)
    }

    func testTrueMultipliedByTrue() throws {
        // Given
        let e1 = MBool(value: true)
        let e2 = MBool(value: true)

        // When
        let multiplication = MMultiplication(left: e1, right: e2).eval()

        // Then
        guard let mBool = multiplication as? MBool else {
            XCTFail("multiplication of two MBool must be MBool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }

    func testTrueMultipliedByFalse() throws {
        // Given
        let e1 = MBool(value: true)
        let e2 = MBool(value: false)

        // When
        let multiplication = MMultiplication(left: e1, right: e2).eval()

        // Then
        guard let mBool = multiplication as? MBool else {
            XCTFail("multiplication of two MBool must be MBool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }

    func testFalseMultipliedByTrue() throws {
        // Given
        let e1 = MBool(value: true)
        let e2 = MBool(value: true)

        // When
        let multiplication = MMultiplication(left: e1, right: e2).eval()

        // Then
        guard let mBool = multiplication as? MBool else {
            XCTFail("multiplication of two MBool must be MBool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }

    func testFalseMultipliedByFalse() throws {
        // Given
        let e1 = MBool(value: true)
        let e2 = MBool(value: true)

        // When
        let multiplication = MMultiplication(left: e1, right: e2).eval()

        // Then
        guard let mBool = multiplication as? MBool else {
            XCTFail("multiplication of two MBool must be MBool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }
}
