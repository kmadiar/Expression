//
//  E+IsZero.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 01.11.2022.
//

import Foundation

extension E {
    struct IsZero {
        let value: Expression

        init(value: Expression) {
            self.value = value
        }
    }
}

extension E.IsZero: Expression {
    func eval(_ context: E.Context) throws -> Expression {
        do {
            if let int = try value.eval(context) as? E.Int {
                return E.Bool(value: int.value == 0)
            }
            if let float = try value.eval(context) as? E.Float {
                return E.Bool(value: float.value == .zero)
            }
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "Is Zero",
                                           level: error.level + 1))
        }
        throw E.Error.wrongArgument(.init(parent: nil,
                                          input: unparse(),
                                          level: 0))
    }

    func unparse() -> Any {
        ["is_zero", value.unparse()]
    }
}
