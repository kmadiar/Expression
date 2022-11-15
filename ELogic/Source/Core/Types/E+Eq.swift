//
//  E+Eq.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 14.11.2022.
//

import Foundation

extension E {
    struct Eq {
        let left: Expression
        let right: Expression
    }
}

extension E.Eq: Expression {
    func eval(_ context: E.Context) throws -> Expression {
        guard let left = try left.eval(context) as? E.Int,
              let right = try right.eval(context) as? E.Int else {
            throw E.Error.wrongArgument(.init(parent: nil,
                                              input: [left.unparse(), right.unparse()],
                                              level: 0))
        }
        return E.Bool(value: left.value == right.value)
    }

    func unparse() -> Any {
        ["eq", left.unparse(), right.unparse()]
    }
}
