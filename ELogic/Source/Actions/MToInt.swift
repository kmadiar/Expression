//
//  MToInt.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public struct MToInt {
    public let value: Expression

    public init(value: Expression) {
        self.value = value
    }
}

extension MToInt: Expression {
    public func unparse() -> Any {
        ["to_int", value.unparse()]
    }

    public func eval() -> Expression {
        evalMInt() ??
        evalMFloat() ??
        evalMBool() ??
        self
    }

    func evalMFloat() -> Expression? {
        if let value = value.eval() as? MFloat {
            return MInt(value: Int(value.value))
        }
        return nil
    }

    func evalMInt() -> Expression? {
        if let value = value.eval() as? MInt {
            return value
        }
        return nil
    }

    func evalMBool() -> Expression? {
        if let value = value.eval() as? MBool {
            return MFloat(value: value.value ? 1.0 : 0.0)
        }
        return nil
    }
}
