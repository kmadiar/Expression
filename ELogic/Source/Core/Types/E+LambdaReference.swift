//
//  E+LambdaReference.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 13.11.2022.
//

import Foundation

extension E {
    struct LambdaReference {
        let variable: [String]
        let body: Expression
        let closure: Context

        init(variable: [String],
             body: Expression,
             closure: Context) {
            self.variable = variable
            self.body = body
            self.closure = closure
        }
    }
}

extension E.LambdaReference: Expression {
    func unparse() -> Any {
        ["lambda_ref", variable, body.unparse()]
    }

    func eval(_ context: E.Context) throws -> Expression {
        self
    }
}
