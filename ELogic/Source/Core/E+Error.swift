//
//  MError.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public extension E {
    class CoreError {
        public init(parent: E.Error?,
                    input: Any,
                    level: Swift.Int) {
            self.parent = parent
            self.input = input
            self.level = level
        }

        public var parent: E.Error?
        public var input: Any
        public var level: Swift.Int
    }
    enum Error: Swift.Error {
        case devisionByZero(CoreError)
        case wrongArgument(CoreError)
        case wrongArgumentsCount(CoreError)
        case emptyList(CoreError)
        case unknownOperation(CoreError)
        case unknownType(CoreError)
        case badInput(CoreError)
        case parseError(CoreError)
    }

}

extension E.Error: CustomDebugStringConvertible {
    public var debugDescription: String {
        errorMessage(level: level - 1)
    }

    public func errorMessage(level: Int) -> String {
        let message: String
        let inputError: E.CoreError
        switch self {
        case let .devisionByZero(input):
            inputError = input
            message = "devision by zero"
        case let .wrongArgument(input):
            inputError = input
            message = "operation doesn't support this argument type"
        case let .wrongArgumentsCount(input):
            inputError = input
            message = "argumenes count is incorrect for operation"
        case let .emptyList(input):
            inputError = input
            message = "empty lists aren't supported"
        case let .unknownOperation(input):
            inputError = input
            message = "unknown keyword"
        case let .badInput(input):
            inputError = input
            message = "Invalid input"
        case let .parseError(input):
            inputError = input
            message = "Parse error"
        case let .unknownType(input):
            inputError = input
            message = "Unknown type"
        }
        var output = message + " " + "\(inputError.input)"
        if let parentError = inputError.parent {
            output += Array(repeating: "\t", count: level).reduce("\n", +)
            output += parentError.errorMessage(level: level - 1)
        }
        return output
    }

    public var coreError: E.CoreError {
        switch self {
        case let .devisionByZero(cError): return cError
        case let .wrongArgument(cError): return cError
        case let .wrongArgumentsCount(cError): return cError
        case let .emptyList(cError): return cError
        case let .unknownOperation(cError): return cError
        case let .badInput(cError): return cError
        case let .parseError(cError): return cError
        case let .unknownType(cError): return cError
        }
    }

    public var level: Int {
        coreError.level
    }
}
