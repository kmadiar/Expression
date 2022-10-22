//
//  Sugar+ToFloat.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

/// Sugar operation type representing negation
public extension Sugar {
    struct ToFloat {
        public let value: SugarExpression

        public init(value: SugarExpression) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.ToFloat: SugarExpression {
    public func deSugarC() -> String {
        "(float)\(value.deSugarC())"
    }

    public func deSugar() -> Expression {
        E.ToFloat(value: value.deSugar())
    }
}
