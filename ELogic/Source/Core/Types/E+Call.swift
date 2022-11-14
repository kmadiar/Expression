//
//  E+Call.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 13.11.2022.
//

import Foundation

extension E {
    struct Call {
        let function: Expression
        let parameter: [Expression]
    }
}

extension E.Call: Expression {
    func unparse() -> Any {
        ["call", function.unparse(), parameter.map { $0.unparse() }]
    }

    func eval(_ context: E.Context) throws -> Expression {
        // creates closure instance with captured context
        let reference = try function.eval(context)
        guard let reference = reference as? E.LambdaReference else {
            throw E.Error.wrongArgument(.init(parent: nil,
                                              input: reference.unparse(),
                                              level: 0))
        }

        let referenceContext = reference.closure.expand()
        // evaluates parameter in captures context
        let parameter = try parameter.map { try $0.eval(context) }

        guard parameter.count == reference.variable.count else {
            throw E.Error.wrongArgument(.init(parent: nil,
                                              input: unparse(),
                                              level: 0))
        }

        for i in 0..<parameter.count {
            referenceContext.variables.bindings[reference.variable[i]] = parameter[i]
        }

        // evaluate function body with captured context
        return try reference.body.eval(referenceContext)
    }
}
