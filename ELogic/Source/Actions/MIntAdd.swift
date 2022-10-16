//
//  MIntAdd.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public struct MIntAdd {
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

extension MIntAdd: MExpression {
    public func unparse() -> Any {
        ["int_add", left.unparse(), right.unparse()]
    }

    public func eval() -> MExpression {
        evalToInt() ??
        self
    }

    func evalToInt() -> MExpression? {
        if let left = MToInt(value: left).eval() as? MInt,
           let right = MToInt(value: right).eval() as? MInt {
            return left + right
        }

        return nil
    }
}
