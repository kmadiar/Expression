//
//  Sugar+Let.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 08.11.2022.
//

import Foundation

/// Sugar operation type representing let
public extension Sugar {
    struct Let {
        public let name: String
        public let value: SugarExpression
        public let body: SugarExpression

        public init(name: String, value: SugarExpression, body: SugarExpression) {
            self.name = name
            self.value = value
            self.body = body
        }
    }
}

extension Sugar.Let: SugarExpression {
    public func deSugar() throws -> Expression {
        E.Do(values: [E.SetVar(left: name,
                               right: try value.deSugar()),
                      try body.deSugar()])
    }

    public func deSugarC() -> String {
        "" // TODO: - add implementation
    }
}
