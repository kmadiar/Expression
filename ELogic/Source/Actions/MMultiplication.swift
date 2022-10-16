//
//  MMultiplication.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public struct MMultiplication {
    public let left: MExpression
    public let right: MExpression

    public init(_ values: (left: MExpression, right: MExpression)) {
        self.init(left: values.left, right: values.right)
    }

    public init(left: MExpression, right: MExpression) {
        self.left = left
        self.right = right
    }
}

extension MMultiplication: MExpression {
    public func unparse() -> Any {
        ["mul", left.unparse(), right.unparse()]
    }

    public func eval() -> MExpression {
        evalMInt() ??
        evalMFloat() ??
        evalMBool() ??
        evalIntFloat() ??
        self
    }

    func evalMBool() -> MExpression? {
        if let left = left.eval() as? MBool,
           let right = right.eval() as? MBool {
            return left * right
        }
        return nil
    }

    func evalMFloat() -> MExpression? {
        if let left = left.eval() as? MFloat,
           let right = right.eval() as? MFloat {
            return left * right
        }
        return nil
    }

    func evalMInt() -> MExpression? {
        if let multX = left.eval() as? MInt,
           let multY = right.eval() as? MInt {
            return multX * multY
        }
        return nil
    }

    func evalIntFloat() -> MExpression? {
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
