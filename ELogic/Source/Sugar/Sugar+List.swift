//
//  Sugar+List.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 19.10.2022.
//

import Foundation

/// Sugar operation type representing list
public extension Sugar {
    struct List {
        public let value: [SugarExpression]

        public init(value: [SugarExpression]) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.List: SugarExpression {
    public func deSugar() throws -> Expression {
        E.List(value: try value.map { try $0.deSugar() })
    }
}
