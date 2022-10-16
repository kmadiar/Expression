//
//  Parser.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public protocol EParser {
    func parse(_ input: Any) throws -> MExpression
}

public class ParserImplementation: EParser {
    public init() {}

    public func parse(_ input: Any) throws -> MExpression {
        if let type = parseType(input: input) {
            return type
        }
        return try parseList(input)
    }
}

private extension ParserImplementation {
    func parseList(_ input: Any) throws -> MExpression {
        if var input = input as? Array<Any> {
            guard let operation = input.first as? String else {
                throw MError.emptyList
            }
            input.removeFirst()
            switch operation {
            case "add":
                return try handleAdd(input)
            case "mul":
                return try handleMultiplication(input)
            case "to_int":
                return try handleToInt(input)
            case "to_float":
                return try handleToFloat(input)
            case "int_add":
                return try handleIntAdd(input)
            case "float_add":
                return try handleFloatAdd(input)
            case "int_mul":
                return try handleIntMultiplication(input)
            case "float_mul":
                return try handleFloatMultiplication(input)
            default:
                throw MError.unknownOperation
            }
        }

        throw MError.unknownOperation
    }
}

// MARK: - Parse operations
private extension ParserImplementation {
    func handleAdd(_ input: Array<Any>) throws -> MExpression {
        try MAdd(twoArguments(input))
    }

    func handleIntAdd(_ input: Array<Any>) throws -> MExpression {
        try MIntAdd(twoArguments(input))
    }

    func handleFloatAdd(_ input: Array<Any>) throws -> MExpression {
        try MFloatAdd(twoArguments(input))
    }

    func handleMultiplication(_ input: Array<Any>) throws -> MExpression {
        try MMultiplication(twoArguments(input))
    }

    func handleIntMultiplication(_ input: Array<Any>) throws -> MExpression {
        try MIntMul(twoArguments(input))
    }

    func handleFloatMultiplication(_ input: Array<Any>) throws -> MExpression {
        try MFloatMul(twoArguments(input))
    }

    func handleToInt(_ input: Array<Any>) throws -> MExpression {
        try MToInt(value: singleArgument(input))
    }

    func handleToFloat(_ input: Array<Any>) throws -> MExpression {
        try MToFloat(value: singleArgument(input))
    }
}

// MARK: - Parse types
private extension ParserImplementation {
    func twoArguments(_ input: Array<Any>) throws -> (MExpression, MExpression) {
        try argumentCountCheck(input, count: 2)
        let left = try parse(input[0])
        let right = try parse(input[1])
        return (left, right)
    }

    func singleArgument(_ input: Array<Any>) throws -> MExpression {
        try argumentCountCheck(input, count: 1)
        return try parse(input[0])
    }

    func argumentCountCheck(_ input: Array<Any>, count: Int) throws {
        guard input.count == count else {
            throw MError.wrongArgumentsCount
        }
    }

    func parseType( input: Any) -> MExpression? {
        parseInt(input) ??
        parseFloat(input) ??
        parseBool(input) ??
        nil
    }

    func parseBool(_ input: Any) -> MExpression? {
        if let input = input as? Bool {
            return MBool(value: input)
        }

        return nil
    }

    func parseInt(_ input: Any) -> MExpression? {
        if let input = input as? Int {
            return MInt(x: input)
        }
        return nil
    }

    func parseFloat(_ input: Any) -> MExpression? {
        if let input = input as? Double {
            return MFloat(value: Float(input))
        }

        return nil
    }
}
