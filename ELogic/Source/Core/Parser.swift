//
//  Parser.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public protocol Parser {
    func parse(_ input: Any) throws -> Expression
}

public class ParserImplementation: Parser {
    public init() {}

    public func parse(_ input: Any) throws -> Expression {
        if let type = parseType(input: input) {
            return type
        }
        return try parseList(input)
    }
}

private extension ParserImplementation {
    func parseList(_ input: Any) throws -> Expression {
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
    func handleAdd(_ input: Array<Any>) throws -> Expression {
        try MAdd(twoArguments(input))
    }

    func handleIntAdd(_ input: Array<Any>) throws -> Expression {
        try MIntAdd(twoArguments(input))
    }

    func handleFloatAdd(_ input: Array<Any>) throws -> Expression {
        try MFloatAdd(twoArguments(input))
    }

    func handleMultiplication(_ input: Array<Any>) throws -> Expression {
        try MMultiplication(twoArguments(input))
    }

    func handleIntMultiplication(_ input: Array<Any>) throws -> Expression {
        try MIntMul(twoArguments(input))
    }

    func handleFloatMultiplication(_ input: Array<Any>) throws -> Expression {
        try MFloatMul(twoArguments(input))
    }

    func handleToInt(_ input: Array<Any>) throws -> Expression {
        try MToInt(value: singleArgument(input))
    }

    func handleToFloat(_ input: Array<Any>) throws -> Expression {
        try MToFloat(value: singleArgument(input))
    }
}

// MARK: - Parse types
private extension ParserImplementation {
    func twoArguments(_ input: Array<Any>) throws -> (Expression, Expression) {
        try argumentCountCheck(input, count: 2)
        let left = try parse(input[0])
        let right = try parse(input[1])
        return (left, right)
    }

    func singleArgument(_ input: Array<Any>) throws -> Expression {
        try argumentCountCheck(input, count: 1)
        return try parse(input[0])
    }

    func argumentCountCheck(_ input: Array<Any>, count: Int) throws {
        guard input.count == count else {
            throw MError.wrongArgumentsCount
        }
    }

    func parseType( input: Any) -> Expression? {
        parseInt(input) ??
        parseFloat(input) ??
        parseBool(input) ??
        nil
    }

    func parseBool(_ input: Any) -> Expression? {
        if let input = input as? Bool {
            return MBool(value: input)
        }

        return nil
    }

    func parseInt(_ input: Any) -> Expression? {
        if let input = input as? Int {
            return MInt(value: input)
        }
        return nil
    }

    func parseFloat(_ input: Any) -> Expression? {
        if let input = input as? Double {
            return MFloat(value: Float(input))
        }

        return nil
    }
}
