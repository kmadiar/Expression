//
//  Sugar+IsZero.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 01.11.2022.
//

import Foundation

/// Sugar operation type representing zero check
public extension Sugar {
    struct IsZero {
        public let value: SugarExpression

        public init(value: SugarExpression) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.IsZero: SugarExpression {
    public func deSugar() throws -> Expression {
        E.IsZero(value: try value.deSugar())
    }

    public func deSugarC() -> String {
        "" // TODO: - add translation
    }
}
