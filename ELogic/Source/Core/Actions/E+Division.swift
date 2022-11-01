//
//  E+Division.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 01.11.2022.
//

import Foundation

extension E {
    struct Division {
        let left: Expression
        let right: Expression

        init(_ values: (left: Expression, right: Expression)) {
            self.init(left: values.left, right: values.right)
        }

        init(left: Expression, right: Expression) {
            self.left = left
            self.right = right
        }
    }
}

extension E.Division: Expression {
    func unparse() -> Any {
        ["div", left.unparse(), right.unparse()]
    }

    func eval() throws -> Expression {
        do {
            if let int = try evalEInt() {
                return int
            }
            if let float = try evalEFloat() {
                return float
            }

        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "Division",
                                           level: error.level + 1))
        }
        throw E.Error.wrongArgument(.init(parent: nil,
                                          input: unparse(),
                                          level: 0))
    }

    func evalEFloat() throws -> Expression? {
        if let left = try left.eval() as? E.Float,
           let right = try right.eval() as? E.Float {
            if right.value == .zero {
                throw E.Error.devisionByZero(.init(parent: nil,
                                                   input: unparse(),
                                                   level: 0))
            }
            return left / right
        }
        return nil
    }

    func evalEInt() throws -> Expression? {
        if let left = try left.eval() as? E.Int,
           let right = try right.eval() as? E.Int {
            if right.value == .zero {
                throw E.Error.devisionByZero(.init(parent: nil,
                                                   input: unparse(),
                                                   level: 0))
            }
            return left / right
        }
        return nil
    }
}
