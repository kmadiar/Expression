//
//  Sugar+Lt.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 01.11.2022.
//

import Foundation

/// Sugar operation type representing addition
public extension Sugar {
    struct Lt {
        public enum TypeHelper: String {
            case int = "int_lt"
            case float = "float_lt"
            case generic = "lt"
        }

        public let left: SugarExpression
        public let right: SugarExpression
        public var typeHelper: TypeHelper = .generic

        public init(_ values: (left: SugarExpression, right: SugarExpression)) {
            self.init(left: values.left, right: values.right)
        }

        public init(left: SugarExpression, right: SugarExpression) {
            self.left = left
            self.right = right
        }
    }
}

// MARK: - Expression conformance
extension Sugar.Lt: SugarExpression {
    public func deSugarC() -> String {
        "(\(left.deSugarC()) < \(right.deSugarC()))"
    }

    public func deSugar() throws -> Expression {
        do {
            switch typeHelper {
            case .int, .generic:
                return try deSugarInt(left: left, right: right)
            case .float:
                return try deSugarFloat(left: left, right: right)
            }
        } catch let error as E.Error {
            throw E.Error.wrongArgument(.init(parent: error,
                                              input: Sugar.Lt.self,
                                              level: error.level + 1))
        }

    }

    func deSugarInt(left: SugarExpression,
                    right: SugarExpression) throws -> Expression {
        guard let left = try Sugar.ToInt(value: left).deSugar().eval() as? E.Int,
              let right = try Sugar.ToInt(value: right).deSugar().eval() as? E.Int else {
            throw E.Error.wrongArgument(.init(parent: nil,
                                              input: [left, right],
                                              level: 0))
        }
        return E.Bool(value: left.value < right.value)
    }

    func deSugarFloat(left: SugarExpression,
                      right: SugarExpression) throws -> Expression {
        guard let left = try Sugar.ToFloat(value: left).deSugar().eval() as? E.Float,
              let right = try Sugar.ToFloat(value: right).deSugar().eval() as? E.Float else {
            throw E.Error.wrongArgument(.init(parent: nil,
                                              input: [left, right],
                                              level: 0))
        }
        return E.Bool(value: left.value < right.value)
    }
}
