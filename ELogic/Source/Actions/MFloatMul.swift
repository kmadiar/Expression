//
//  MFloatAdd.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public struct MFloatMul {
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

extension MFloatMul: MExpression {
    public func unparse() -> Any {
        ["float_mul", left.unparse(), right.unparse()]
    }

    public func eval() -> MExpression {
        evalToFloat() ??
        self
    }

    func evalToFloat() -> MExpression? {
        if let left = MToFloat(value: left).eval() as? MFloat,
           let right = MToFloat(value: right).eval() as? MFloat {
            return left * right
        }

        return nil
    }
}
