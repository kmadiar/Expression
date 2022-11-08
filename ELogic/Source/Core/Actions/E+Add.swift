//
//  MAdd.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

extension E {
    struct Add {
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

extension E.Add: Expression {
    func unparse() -> Any {
        ["add", left.unparse(), right.unparse()]
    }

    func eval(_ context: E.Context) throws -> Expression {
        do {
            if let int = try evalEInt(context) {
                return int
            }
            if let float = try evalEFloat(context) {
                return float
            }
            if let bool = try evalEBool(context) {
                return bool
            }
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "Add",
                                           level: error.level + 1))
        }
        throw E.Error.wrongArgument(.init(parent: nil,
                                          input: unparse(),
                                          level: 0))
    }

    func evalEFloat(_ context: E.Context) throws -> Expression? {
        if let addX = try left.eval(context) as? E.Float,
           let addY = try right.eval(context) as? E.Float {
            return addX + addY
        }

        return nil
    }

    func evalEInt(_ context: E.Context) throws -> Expression? {
        if let addX = try left.eval(context) as? E.Int,
           let addY = try right.eval(context) as? E.Int {
            return addX + addY
        }
        return nil
    }

    func evalEBool(_ context: E.Context) throws -> Expression? {
        if let left = try left.eval(context) as? E.Bool,
           let right = try right.eval(context) as? E.Bool {
            return left + right
        }
        return nil
    }
}
