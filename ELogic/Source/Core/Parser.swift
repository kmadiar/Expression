//
//  Parser.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public protocol Parser {
    func parse(_ input: Any) throws -> SugarExpression
}

public class ParserImplementation: Parser {
    public init() {}

    public func parse(_ input: Any) throws -> SugarExpression {
        if let type = parseType(input: input) {
            return type
        }
        return try parseList(input)
    }
}

private extension ParserImplementation {
    func parseList(_ input: Any) throws -> SugarExpression {
        if var input = input as? Array<Any> {
            guard let operation = input.first as? String else {
                throw MError.emptyList
            }
            input.removeFirst()
            switch operation {
            case "add":
                return try handleAdd(input)
            case "sum":
                return try handleSum(input)
            case "mul":
                return try handleMultiplication(input)
            case "sub":
                return try handleSubtract(input)
            case "neg":
                return try handleNegation(input)
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
    // MARK: - negation
    func handleNegation(_ input: Array<Any>) throws -> SugarExpression {
        try Sugar.Neg(value: singleArgument(input))
    }
    // MARK: - subtraction
    func handleSubtract(_ input: Array<Any>) throws -> SugarExpression {
        try Sugar.Subtract(twoArguments(input))
    }

    // MARK: - addition
    func handleSum(_ input: Array<Any>) throws -> SugarExpression {
        try Sugar.Sum(input.map(parse))
    }

    func handleAdd(_ input: Array<Any>) throws -> SugarExpression {
        try Sugar.Add(twoArguments(input))
    }

    func handleIntAdd(_ input: Array<Any>) throws -> SugarExpression {
        var operation = try Sugar.Add(twoArguments(input))
        operation.typeHelper = .int
        return operation
    }

    func handleFloatAdd(_ input: Array<Any>) throws -> SugarExpression {
        var operation = try Sugar.Add(twoArguments(input))
        operation.typeHelper = .float
        return operation
    }

    // MARK: - Mupltiplication
    func handleMultiplication(_ input: Array<Any>) throws -> SugarExpression {
        try Sugar.Multiplication(twoArguments(input))
    }

    func handleIntMultiplication(_ input: Array<Any>) throws -> SugarExpression {
        var operation = try Sugar.Multiplication(twoArguments(input))
        operation.typeHelper = .int
        return operation
    }

    func handleFloatMultiplication(_ input: Array<Any>) throws -> SugarExpression {
        var operation = try Sugar.Multiplication(twoArguments(input))
        operation.typeHelper = .float
        return operation
    }

    func handleToInt(_ input: Array<Any>) throws -> SugarExpression {
        try Sugar.ToInt(value: singleArgument(input))
    }

    func handleToFloat(_ input: Array<Any>) throws -> SugarExpression {
        try Sugar.ToFloat(value: singleArgument(input))
    }
}

// MARK: - Parse types
private extension ParserImplementation {
    func twoArguments(_ input: Array<Any>) throws -> (SugarExpression, SugarExpression) {
        try argumentCountCheck(input, count: 2)
        let left = try parse(input[0])
        let right = try parse(input[1])
        return (left, right)
    }

    func singleArgument(_ input: Array<Any>) throws -> SugarExpression {
        try argumentCountCheck(input, count: 1)
        return try parse(input[0])
    }

    func argumentCountCheck(_ input: Array<Any>, count: Int) throws {
        guard input.count == count else {
            throw MError.wrongArgumentsCount
        }
    }

    func parseType( input: Any) -> SugarExpression? {
        parseInt(input) ??
        parseFloat(input) ??
        parseBool(input) ??
        nil
    }

    func parseBool(_ input: Any) -> SugarExpression? {
        if let input = input as? Bool {
            return Sugar.Bool(value: input)
        }

        return nil
    }

    func parseInt(_ input: Any) -> SugarExpression? {
        if let input = input as? Int {
            return Sugar.Integer(value: input)
        }
        return nil
    }

    func parseFloat(_ input: Any) -> SugarExpression? {
        if let input = input as? Double {
            return Sugar.Float(value: Float(input))
        }

        return nil
    }
}
