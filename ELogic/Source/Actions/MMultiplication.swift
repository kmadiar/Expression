//
//  MMultiplication.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public struct MMultiplication {
    public let x: MExpression
    public let y: MExpression

    public init(x: MExpression, y: MExpression) {
        self.x = x
        self.y = y
    }
}

extension MMultiplication: MExpression {
    public func eval() -> MExpression {
        evalMInt() ??
        evalMBool() ??
        self
    }

    func evalMBool() -> MExpression? {
        if let left = x.eval() as? MBool,
           let right = y.eval() as? MBool {
            return left * right
        }
        return nil
    }

    func evalMInt() -> MExpression? {
        if let multX = x.eval() as? MInt,
           let multY = y.eval() as? MInt {
            return multX * multY
        }
        return nil
    }
}
