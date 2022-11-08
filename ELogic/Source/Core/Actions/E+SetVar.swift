//
//  E+SetVar.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.11.2022.
//

import Foundation

extension E {
    struct SetVar {
        let left: String
        let right: Expression

        init(left: String, right: Expression) {
            self.left = left
            self.right = right
        }
    }
}

extension E.SetVar: Expression {
    func eval(_ context: E.Context) throws -> Expression {
        let output = try right.eval(context)

        context.variables.addBinding(left, value: output)
        return output
    }

    func unparse() -> Any {
        "setVar, \(left), \(right)"
    }
}
