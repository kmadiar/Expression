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
        if let type = try parseType(input: input) {
            return type
        }
        return try parseList(input)
    }
}

private extension ParserImplementation {
    func parseList(_ input: Any) throws -> SugarExpression {
        if var localInput = input as? Array<Any> {
            guard let operation = localInput.first as? String else {
                throw E.Error.emptyList(.init(parent: nil,
                                              input: localInput, level: 0))
            }
            localInput.removeFirst()
            switch operation {
            case "and":
                return try handleAnd(localInput)
            case "or":
                return try handleOr(localInput)
            case "not":
                return try handleNot(localInput)
            case "add":
                return try handleAdd(localInput)
            case "sum":
                return try handleSum(localInput)
            case "mul":
                return try handleMultiplication(localInput)
            case "div":
                return try handleDivision(localInput)
            case "sub":
                return try handleSubtract(localInput)
            case "neg":
                return try handleNegation(localInput)
            case "list":
                return try handleList(localInput)
            case "append_list":
                return try handleAppendList(localInput)
            case "head_list":
                return try handleHeadList(localInput)
            case "tail_list":
                return try handleTailList(localInput)
            case "to_int":
                return try handleToInt(localInput)
            case "to_float":
                return try handleToFloat(localInput)
            case "int_add":
                return try handleIntAdd(localInput)
            case "float_add":
                return try handleFloatAdd(localInput)
            case "int_mul":
                return try handleIntMultiplication(localInput)
            case "float_mul":
                return try handleFloatMultiplication(localInput)
            case "is_zero":
                return try handleIsZero(localInput)
            case "lt":
                return try handleLt(localInput)
            case "gt":
                return try handleGt(localInput)
            case "setvar":
                return try handleSetVar(localInput)
            case "do":
                return try handleDo(localInput)
            case "let":
                return try handleLet(localInput)
            case "let*":
                return try handleLetStar(localInput)
            case "lambda":
                return try handleLambda(localInput)
            case "call":
                return try handleCall(localInput)
            case "fun":
                return try handleFun(localInput)
            case "if":
                return try handleIf(localInput)
            default:
                throw E.Error.unknownOperation(.init(parent: nil,
                                                     input: operation, level: 0))
            }
        }

        throw E.Error.unknownType(.init(parent: nil,
                                        input: input, level: 0))
    }
}

// MARK: - Parse operations
private extension ParserImplementation {
    // MARK: - variables
    func handleIf(_ input: Array<Any>) throws -> SugarExpression {
        do {
            try argumentCountCheck(input, count: 3)

            let condition = try parse(input[0])
            let mainBranch = try parse(input[1])
            let altBranch = try parse(input[2])

            return Sugar.If(condition: condition,
                            mainBranch: mainBranch,
                            altBranch: altBranch)
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: input,
                                           level: error.level + 1))
        }
    }
    func handleFun(_ input: Array<Any>) throws -> SugarExpression {
        do {
            try argumentCountCheck(input, count: 3)
            var localInput = input
            guard let name = localInput.removeFirst() as? String else {
                throw E.Error.wrongArgument(.init(parent: nil,
                                                  input: localInput[0],
                                                  level: 0))
            }
            guard let lambda = try handleLambda(localInput) as? Sugar.Lambda else {
                throw E.Error.wrongArgument(.init(parent: nil,
                                                  input: localInput[0],
                                                  level: 0))
            }


            return Sugar.Func(name: name,
                              argumentNames: lambda.variable,
                              body: lambda.body)
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: input,
                                           level: error.level + 1))
        }
    }
    func handleCall(_ input: Array<Any>) throws -> SugarExpression {
        do {
            try argumentCountCheck(input, count: 2)

            guard let params = input[1] as? Array<Any> else {
                throw E.Error.wrongArgument(.init(parent: nil,
                                                  input: input,
                                                  level: 0))
            }
            return Sugar.Call(function: try parse(input[0]),
                              param: try params.map { try parse($0) })

        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: input,
                                           level: error.level + 1))
        }
    }

    func handleLambda(_ input: Array<Any>) throws -> SugarExpression {
        do {
            try argumentCountCheck(input, count: 2)

            guard let variable = input[0] as? [String] else {
                throw E.Error.wrongArgument(.init(parent: nil,
                                                  input: input,
                                                  level: 0))
            }

            return Sugar.Lambda(variable: variable,
                                body: try parse(input[1]))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: input,
                                           level: error.level + 1))
        }
    }

    func handleLetStar(_ input: Array<Any>) throws -> SugarExpression {
        do {
            var localInput = input
            try argumentCountCheck(input, count: 3) { $0 >= $1 }

            let body = try parse(localInput.removeLast())

            var pairs: [(String, SugarExpression)] = []
            while !localInput.isEmpty {
                let arguments = try twoArguments(localInput) { $0 >= $1 }

                guard let name = arguments.0 as? Sugar.Symbol else {
                    throw E.Error.wrongArgument(.init(parent: nil,
                                                      input: input,
                                                      level: 0))
                }
                pairs.append((name.value, arguments.1))
                localInput.removeFirst(2)
            }

            return Sugar.LetStar(bindings: pairs, body: body)
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: input,
                                           level: error.level + 1))
        }
    }

    func handleLet(_ input: Array<Any>) throws -> SugarExpression {
        do {
            try argumentCountCheck(input, count: 3) { $0 >= $1 }
            let name = try parse(input[0])
            let value = try parse(input[1])
            let body = try parse(input[2])

            guard let name = name as? Sugar.Symbol else {
                throw E.Error.wrongArgument(.init(parent: nil,
                                                  input: input,
                                                  level: 0))
            }

            return Sugar.Let(name: name.value,
                             value: value,
                             body: body)
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: input,
                                           level: error.level + 1))
        }
    }

    func handleDo(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return Sugar.Do(value: try input.map(parse))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: input,
                                           level: error.level + 1))
        }
    }
    func handleSetVar(_ input: Array<Any>) throws -> SugarExpression {
        do {
            let arguments = try twoArguments(input)
            guard let name = arguments.0 as? Sugar.Symbol else {
                throw E.Error.wrongArgument(.init(parent: nil,
                                                  input: input,
                                                  level: 0))
            }
            return Sugar.SetVar(left: name.value,
                                right: arguments.1)
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: input,
                                           level: error.level + 1))
        }
    }
    // MARK: - list
    func handleList(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.List(value: input.map(parse))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.List.self, level: error.level + 1))
        }
    }

    func handleAppendList(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.AppendList(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.AppendList.self, level: error.level + 1))
        }
    }

    func handleHeadList(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.HeadList(value: singleArgument(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.HeadList.self, level: error.level + 1))
        }
    }

    func handleTailList(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.TailList(value: singleArgument(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.TailList.self, level: error.level + 1))
        }
    }

    func handleLt(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Lt(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Lt.self,
                                           level: error.level + 1))
        }
    }

    func handleGt(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Gt(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Gt.self,
                                           level: error.level + 1))
        }
    }

    func handleIsZero(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.IsZero(value: singleArgument(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.IsZero.self,
                                           level: error.level + 1))
        }
    }

    // MARK: - negation
    func handleNegation(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Neg(value: singleArgument(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Neg.self, level: error.level + 1))
        }
    }
    // MARK: - subtraction
    func handleSubtract(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Subtract(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Subtract.self, level: error.level + 1))
        }
    }

    // MARK: - addition
    func handleSum(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Sum(input.map(parse))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Sum.self, level: error.level + 1))
        }
    }

    func handleAdd(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Add(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Add.self, level: error.level + 1))
        }
    }

    func handleAnd(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.And(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.And.self, level: error.level + 1))
        }
    }

    func handleOr(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Or(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Or.self, level: error.level + 1))
        }
    }

    func handleNot(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Not(value: singleArgument(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Not.self, level: error.level + 1))
        }
    }

    func handleIntAdd(_ input: Array<Any>) throws -> SugarExpression {
        do {
            var operation = try Sugar.Add(twoArguments(input))
            operation.typeHelper = .int
            return operation
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "Int Add", level: error.level + 1))
        }
    }

    func handleFloatAdd(_ input: Array<Any>) throws -> SugarExpression {
        do {
            var operation = try Sugar.Add(twoArguments(input))
            operation.typeHelper = .float
            return operation
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "Float Add", level: error.level + 1))
        }
    }

    // MARK: - Mupltiplication
    func handleMultiplication(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Multiplication(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Multiplication.self, level: error.level + 1))
        }
    }

    func handleDivision(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.Division(twoArguments(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Division.self, level: error.level + 1))
        }
    }

    func handleIntMultiplication(_ input: Array<Any>) throws -> SugarExpression {
        do {
            var operation = try Sugar.Multiplication(twoArguments(input))
            operation.typeHelper = .int
            return operation
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "Int Multiplication", level: error.level + 1))
        }
    }

    func handleFloatMultiplication(_ input: Array<Any>) throws -> SugarExpression {
        do {
            var operation = try Sugar.Multiplication(twoArguments(input))
            operation.typeHelper = .float
            return operation
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "Float Multiplication", level: error.level + 1))
        }
    }

    func handleToInt(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.ToInt(value: singleArgument(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.ToInt.self, level: error.level + 1))
        }
    }

    func handleToFloat(_ input: Array<Any>) throws -> SugarExpression {
        do {
            return try Sugar.ToFloat(value: singleArgument(input))
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.ToFloat.self, level: error.level + 1))
        }
    }
}

// MARK: - Parse types
private extension ParserImplementation {
    func twoArguments(_ input: Array<Any>,
                      comparator: (Int, Int) -> Bool = { $0 == $1 }) throws -> (SugarExpression, SugarExpression) {
        try argumentCountCheck(input, count: 2, comparator: comparator)
        let left = try parse(input[0])
        let right = try parse(input[1])
        return (left, right)
    }

    func singleArgument(_ input: Array<Any>) throws -> SugarExpression {
        try argumentCountCheck(input, count: 1)
        return try parse(input[0])
    }

    func argumentCountCheck(_ input: Array<Any>,
                            count: Int,
                            comparator: (Int, Int) -> Bool = { $0 == $1 }) throws {
        guard comparator(input.count, count) else {
            throw E.Error.wrongArgumentsCount(.init(parent: nil,
                                                    input: input, level: 0))
        }
    }

    func parseType( input: Any) throws -> SugarExpression? {
        if let int =  parseInt(input) {
            return int
        }
        if let float = parseFloat(input) {
            return float
        }
        if let bool = parseBool(input) {
            return bool
        }
        if let symbol = try parseSymbol(input) {
            return symbol
        }
        return nil
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

    func parseSymbol(_ input: Any) throws -> SugarExpression? {
        if let localInput = input as? String {
            return Sugar.Symbol(value: localInput)
        }

        return nil
    }
}
