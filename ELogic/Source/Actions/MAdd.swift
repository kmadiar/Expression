//
//  MAdd.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public struct MAdd {
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

extension MAdd: MExpression {
    public func unparse() -> Any {
        ["add", left.unparse(), right.unparse()]
    }

    public func eval() -> MExpression {
        evalMInt() ??
        evalMFloat() ??
        evalIntFloat() ??
        evalMBool() ??
        self
    }

    func evalMFloat() -> MExpression? {
        if let addX = left.eval() as? MFloat,
           let addY = right.eval() as? MFloat {
            return addX + addY
        }

        return nil
    }

    func evalMInt() -> MExpression? {
        if let addX = left.eval() as? MInt,
           let addY = right.eval() as? MInt {
            return addX + addY
        }
        return nil
    }

    func evalMBool() -> MExpression? {
        if let left = left.eval() as? MBool,
           let right = right.eval() as? MBool {
            return left + right
        }
        return nil
    }

    func evalIntFloat() -> MExpression? {
        if let left = left.eval() as? MInt,
           let right = right.eval() as? MFloat {
            return MFloat(value: Float(left.value)) + right
        }

        if let left = left.eval() as? MFloat,
           let right = right.eval() as? MInt {
            return left + MFloat(value: Float(right.value))
        }

        return nil
    }
}
