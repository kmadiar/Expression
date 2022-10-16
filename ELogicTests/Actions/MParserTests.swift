//
//  ParserTests.swift
//  ELogicTests
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

import XCTest
@testable import ELogic

class MParserTests: XCTestCase {
    func testFloatMul() throws {
        let parer = ParserImplementation()

        XCTAssertEqual(Float(4.4),
                       try parer.parse(["float_mul", 2, 2.2]).eval().unparse() as! Float)
    }

    func testIntMul() throws {
        let parer = ParserImplementation()

        XCTAssertEqual(4,
                       try parer.parse(["int_mul", 2.0, 2.2]).eval().unparse() as! Int)
    }

    func testFloatAdd() throws {
        let parer = ParserImplementation()

        XCTAssertEqual(Float(4.4),
                       try parer.parse(["float_mul", 2.2, 2]).eval().unparse() as! Float)
    }

    func testIntAdd() throws {
        let parer = ParserImplementation()

        XCTAssertEqual(4,
                       try parer.parse(["int_mul", 2.0, 2.2]).eval().unparse() as! Int)
    }
}
