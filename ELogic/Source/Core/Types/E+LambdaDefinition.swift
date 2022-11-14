//
//  E+LambdaDefinition.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 13.11.2022.
//

import Foundation

extension E {
    struct LambdaDefinition {
        let variable: [String]
        let body: Expression

        init(variable: [String], body: Expression) {
            self.variable = variable
            self.body = body
        }
    }
}

extension E.LambdaDefinition: Expression {
    func unparse() -> Any {
        ["lambda", [variable], body.unparse()]
    }

    func eval(_ context: E.Context) throws -> Expression {
        E.LambdaReference(variable: variable, body: body, closure: context.clone())
    }
}
