//
//  SugarNeg.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

/// Sugar operation type representing negation
public extension Sugar {
    struct Neg {
        public let value: SugarExpression

        public init(value: SugarExpression) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.Neg: SugarExpression {
    public func deSugarC() -> String {
        "(-1 * \(value.deSugarC()))"
    }

    public func deSugar() throws -> Expression {
        E.Multiplication(left: E.Int(value: -1),
                         right: try value.deSugar())
    }
}
