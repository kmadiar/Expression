//
//  MAdd.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public struct MAdd {
    public let x: MExpression
    public let y: MExpression

    public init(x: MExpression, y: MExpression) {
        self.x = x
        self.y = y
    }
}

extension MAdd: MExpression {
    public func eval() -> MExpression {
        evalMInt() ??
        evalMBool() ??
        self
    }

    func evalMInt() -> MExpression? {
        if let addX = x.eval() as? MInt,
           let addY = y.eval() as? MInt {
            return addX + addY
        }
        return nil
    }

    func evalMBool() -> MExpression? {
        if let left = x.eval() as? MBool,
           let right = y.eval() as? MBool {
            return left + right
        }
        return nil
    }
}
