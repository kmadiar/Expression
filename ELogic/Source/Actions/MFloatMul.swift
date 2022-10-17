//
//  MFloatAdd.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public struct MFloatMul {
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

extension MFloatMul: Expression {
    public func unparse() -> Any {
        ["float_mul", left.unparse(), right.unparse()]
    }

    public func eval() -> Expression {
        evalToFloat() ??
        self
    }

    func evalToFloat() -> Expression? {
        if let left = MToFloat(value: left).eval() as? MFloat,
           let right = MToFloat(value: right).eval() as? MFloat {
            return left * right
        }

        return nil
    }
}
