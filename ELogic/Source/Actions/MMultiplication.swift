//
//  MMultiplication.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public struct MMultiplication {
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

extension MMultiplication: Expression {
    public func unparse() -> Any {
        ["mul", left.unparse(), right.unparse()]
    }

    public func eval() -> Expression {
        evalMInt() ??
        evalMFloat() ??
        evalMBool() ??
        evalIntFloat() ??
        self
    }

    func evalMBool() -> Expression? {
        if let left = left.eval() as? MBool,
           let right = right.eval() as? MBool {
            return left * right
        }
        return nil
    }

    func evalMFloat() -> Expression? {
        if let left = left.eval() as? MFloat,
           let right = right.eval() as? MFloat {
            return left * right
        }
        return nil
    }

    func evalMInt() -> Expression? {
        if let multX = left.eval() as? MInt,
           let multY = right.eval() as? MInt {
            return multX * multY
        }
        return nil
    }

    func evalIntFloat() -> Expression? {
        if let left = left.eval() as? MInt,
           let right = right.eval() as? MFloat {
            return MFloat(value: Float(left.value)) * right
        }

        if let left = left.eval() as? MFloat,
           let right = right.eval() as? MInt {
            return left * MFloat(value: Float(right.value))
        }

        return nil
    }
}
