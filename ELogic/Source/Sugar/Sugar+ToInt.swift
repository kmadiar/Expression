//
//  Sugar+ToInt.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

/// Sugar operation type representing negation
public extension Sugar {
    struct ToInt {
        public let value: SugarExpression

        public init(value: SugarExpression) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.ToInt: SugarExpression {
    public func deSugarC() -> String {
        "(int)\(value.deSugarC())"
    }

    public func deSugar() -> Expression {
        MToInt(value: value.deSugar())
    }
}
