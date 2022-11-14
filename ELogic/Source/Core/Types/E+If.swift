//
//  E+If.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 14.11.2022.
//

import Foundation

extension E {
    struct If {
        let condition: Expression
        let mainBranch: Expression
        let altBranch: Expression
    }
}

extension E.If: Expression {
    func eval(_ context: E.Context) throws -> Expression {
        guard let condition = try condition.eval(context) as? E.Bool else {
            throw E.Error.wrongArgument(.init(parent: nil,
                                              input: condition.unparse(),
                                              level: 0))
        }
        return condition.value ? try mainBranch.eval(context) : try altBranch.eval(context)
    }

    func unparse() -> Any {
        ["if", condition.unparse(), mainBranch.unparse(), altBranch.unparse()]
    }
}
