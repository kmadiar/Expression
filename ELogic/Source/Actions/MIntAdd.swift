//
//  MIntAdd.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public struct MIntAdd {
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

extension MIntAdd: Expression {
    public func unparse() -> Any {
        ["int_add", left.unparse(), right.unparse()]
    }

    public func eval() -> Expression {
        evalToInt() ??
        self
    }

    func evalToInt() -> Expression? {
        if let left = MToInt(value: left).eval() as? MInt,
           let right = MToInt(value: right).eval() as? MInt {
            return left + right
        }

        return nil
    }
}
