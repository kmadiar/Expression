//
//  MMultiplication.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

extension E {
    struct Multiplication {
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

extension E.Multiplication: Expression {
    func unparse() -> Any {
        ["mul", left.unparse(), right.unparse()]
    }

    func eval() throws -> Expression {
        do {
            if let int = try evalEInt() {
                return int
            }
            if let float = try evalEFloat() {
                return float
            }
            if let bool = try evalEBool() {
                return bool
            }
            if let intFloat = try evalIntFloat() {
                return intFloat
            }

        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "Multiplication",
                                           level: error.level + 1))
        }
        throw E.Error.wrongArgument(.init(parent: nil,
                                          input: unparse(),
                                          level: 0))
    }

    func evalEBool() throws -> Expression? {
        if let left = try left.eval() as? E.Bool,
           let right = try right.eval() as? E.Bool {
            return left * right
        }
        return nil
    }

    func evalEFloat() throws -> Expression? {
        if let left = try left.eval() as? E.Float,
           let right = try right.eval() as? E.Float {
            return left * right
        }
        return nil
    }

    func evalEInt() throws -> Expression? {
        if let multX = try left.eval() as? E.Int,
           let multY = try right.eval() as? E.Int {
            return multX * multY
        }
        return nil
    }

    func evalIntFloat() throws -> Expression? {
        if let left = try left.eval() as? E.Int,
           let right = try right.eval() as? E.Float {
            return E.Float(value: Float(left.value)) * right
        }

        if let left = try left.eval() as? E.Float,
           let right = try right.eval() as? E.Int {
            return left * E.Float(value: Float(right.value))
        }

        return nil
    }
}
