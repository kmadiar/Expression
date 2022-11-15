//
//  E+FunRecDefinition.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 15.11.2022.
//

import Foundation

extension E {
    struct FunRecDefinition {
        public let name: String
        public let argumentNames: [String]
        public let body: Expression

        public init(name: String, argumentNames: [String], body: Expression) {
            self.name = name
            self.argumentNames = argumentNames
            self.body = body
        }
    }
}

extension E.FunRecDefinition: Expression {
    func eval(_ context: E.Context) throws -> Expression {
        let newContext = context.clone()
        let lambdaRef = E.LambdaReference(variable: argumentNames,
                                          body: body,
                                          closure: newContext)
        newContext.variables.bindings[name] = lambdaRef

        return try E.SetVar(left: name, right: lambdaRef).eval(context)
    }

    func unparse() -> Any {
        ["funrec", name, argumentNames, body.unparse()]
    }
}
