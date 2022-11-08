//
//  E+Symbol.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.11.2022.
//

import Foundation

extension E {
    struct Symbol {
        let value: String

        init(value: String) {
            self.value = value
        }
    }
}

extension E.Symbol: Expression {
    func eval(_ context: E.Context) throws -> Expression {
        var currentContext: E.Context? = context
        while currentContext != nil {
            if let variable = try? currentContext?.variables.get(value) {
                return variable
            }
            currentContext = currentContext?.parent
        }
        throw E.Error.variableNotFound(.init(parent: nil,
                                             input: value,
                                             level: 0))
    }

    func unparse() -> Any {
        value
    }

    func eval() -> Expression {
        self
    }
}
