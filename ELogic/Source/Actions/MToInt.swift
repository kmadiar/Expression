//
//  MToInt.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public struct MToInt {
    public let value: MExpression

    public init(value: MExpression) {
        self.value = value
    }
}

extension MToInt: MExpression {
    public func unparse() -> Any {
        ["to_int", value.unparse()]
    }

    public func eval() -> MExpression {
        evalMInt() ??
        evalMFloat() ??
        evalMBool() ??
        self
    }

    func evalMFloat() -> MExpression? {
        if let value = value.eval() as? MFloat {
            return MInt(x: Int(value.value))
        }
        return nil
    }

    func evalMInt() -> MExpression? {
        if let value = value.eval() as? MInt {
            return value
        }
        return nil
    }

    func evalMBool() -> MExpression? {
        if let value = value.eval() as? MBool {
            return MFloat(value: value.value ? 1.0 : 0.0)
        }
        return nil
    }
}
