//
//  MToFloat.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public struct MToFloat {
    public let value: Expression

    public init(value: Expression) {
        self.value = value
    }
}

extension MToFloat: Expression {
    public func unparse() -> Any {
        ["to_float", value.unparse()]
    }

    public func eval() -> Expression {
        evalMInt() ??
        evalMFloat() ??
        evalMBool() ??
        self
    }

    func evalMFloat() -> Expression? {
        if let value = value.eval() as? MFloat {
            return value
        }
        return nil
    }

    func evalMInt() -> Expression? {
        if let value = value.eval() as? MInt {
            return MFloat(value: Float(value.value))
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
