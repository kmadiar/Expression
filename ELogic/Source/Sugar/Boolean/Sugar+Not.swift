//
//  Sugar+Not.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 01.11.2022.
//

import Foundation

/// Sugar operation type representing Boolean and
public extension Sugar {
    struct Not {
        public let value: SugarExpression

        public init(value: SugarExpression) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.Not: SugarExpression {
    public func deSugarC() -> String {
        "(!\(value.deSugarC()))"
    }

    public func deSugar() throws -> Expression {
        do {
            if let value = try value.deSugar() as? E.Bool {
                return E.Bool(value: !value.value)
            }
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: Sugar.Not.self, level: error.level + 1))
        }

        throw E.Error.wrongArgument(.init(parent: nil,
                                          input: value,
                                          level: 0))
    }
}
