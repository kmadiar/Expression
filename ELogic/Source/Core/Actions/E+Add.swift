//
//  MAdd.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public extension E {
    struct Add {
        public let left: Expression
        public let right: Expression

        public init(_ values: (left: Expression, right: Expression)) {
            self.init(left: values.left, right: values.right)
        }

        public init(left: Expression, right: Expression) {
            self.left = left
            self.right = right
        }
    }
}

extension E.Add: Expression {
    public func unparse() -> Any {
        ["add", left.unparse(), right.unparse()]
    }

    public func eval() -> Expression {
        evalEInt() ??
        evalEFloat() ??
        evalIntFloat() ??
        evalEBool() ??
        self
    }

    func evalEFloat() -> Expression? {
        if let addX = left.eval() as? E.Float,
           let addY = right.eval() as? E.Float {
            return addX + addY
        }

        return nil
    }

    func evalEInt() -> Expression? {
        if let addX = left.eval() as? E.Int,
           let addY = right.eval() as? E.Int {
            return addX + addY
        }
        return nil
    }

    func evalEBool() -> Expression? {
        if let left = left.eval() as? E.Bool,
           let right = right.eval() as? E.Bool {
            return left + right
        }
        return nil
    }

    func evalIntFloat() -> Expression? {
        if let left = left.eval() as? E.Int,
           let right = right.eval() as? E.Float {
            return E.Float(value: Float(left.value)) + right
        }

        if let left = left.eval() as? E.Float,
           let right = right.eval() as? E.Int {
            return left + E.Float(value: Float(right.value))
        }

        return nil
    }
}
