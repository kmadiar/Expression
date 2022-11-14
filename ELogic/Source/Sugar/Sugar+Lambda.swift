//
//  Sugar+Func.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 13.11.2022.
//

import Foundation

/// Sugar operation type representing let star
public extension Sugar {
    struct Lambda {
        public let variable: [String]
        public let body: SugarExpression

        public init(variable: [String], body: SugarExpression) {
            self.variable = variable
            self.body = body
        }
    }
}

extension Sugar.Lambda: SugarExpression {
    public func deSugar() throws -> Expression {
        E.LambdaDefinition(variable: variable,
                           body: try body.deSugar())
    }
}
