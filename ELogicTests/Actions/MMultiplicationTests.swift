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
        let e1 = MInt(x: 1)
        let e2 = MInt(x: 2)

        // When
        let multiplication = MMultiplication(x: e1, y: e2).eval()

        // Then

        guard let multiplication = multiplication as? MInt else {
            XCTFail("multiplication of two MInt must be MInt")
            return
        }

        XCTAssertEqual(multiplication, e1 * e2)
    }

    func testOneMultipliedByBoolean() throws {
        // Given
        let e1 = MInt(x: 1)
        let e2 = MBool(value: true)

        // When
        let multiplication = MMultiplication(x: e1, y: e2).eval()

        // Then

        guard let multiplication = multiplication as? MMultiplication else {
            XCTFail("multiplication of MInt and MBool must be MMultiplication")
            return
        }

        XCTAssertEqual((multiplication.x as? MInt)?.x, e1.x)
        XCTAssertEqual((multiplication.y as? MBool)?.value, e2.value)
    }

    func testOneAddHundredSuccess() throws {
        // Given
        let e1 = MInt(x: 1)
        let e2 = MInt(x: 2)
        let e3 = MInt(x: 100)
        let addition = MMultiplication(x: e1, y: e2)

        // When
        let multiplication = MMultiplication(x: addition, y: e3).eval()


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
        let multiplication = MMultiplication(x: e1, y: e2).eval()

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
        let multiplication = MMultiplication(x: e1, y: e2).eval()

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
        let multiplication = MMultiplication(x: e1, y: e2).eval()

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
        let multiplication = MMultiplication(x: e1, y: e2).eval()

        // Then
        guard let mBool = multiplication as? MBool else {
            XCTFail("multiplication of two MBool must be MBool")
            return
        }

        XCTAssertEqual(mBool.value, e1.value && e2.value)
    }
}
