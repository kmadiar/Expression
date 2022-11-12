//
//  Sugar+Do.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.11.2022.
//

import Foundation

/// Sugar operation type representing scope
public extension Sugar {
    struct Do {
        public let value: [SugarExpression]

        public init(value: [SugarExpression]) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.Do: SugarExpression {
    public func deSugar() throws -> Expression {
        E.Do(values: try value.map { try $0.deSugar() })
    }
}
