//
//  Sugar+Or.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 01.11.2022.
//

import Foundation
/// Sugar operation type representing Boolean Or
public extension Sugar {
    struct Or {
        public let left: SugarExpression
        public let right: SugarExpression

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
extension Sugar.Or: SugarExpression {
    public func deSugarC() -> String {
        "(\(left.deSugarC()) || \(right.deSugarC()))"
    }

    public func deSugar() throws -> Expression {
        do {
            if let left = try left.deSugar() as? E.Bool,
               let right = try right.deSugar() as? E.Bool {
                return E.Bool(value: left.value && right.value)
            }
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Or.self, level: error.level + 1))
        }

        throw E.Error.wrongArgument(.init(parent: nil,
                                          input: [left, right],
                                          level: 0))
    }
}
