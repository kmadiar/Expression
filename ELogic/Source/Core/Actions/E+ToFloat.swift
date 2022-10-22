//
//  MToFloat.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public extension E {
    struct ToFloat {
        public let value: Expression

        public init(value: Expression) {
            self.value = value
        }
    }
}

extension E.ToFloat: Expression {
    public func unparse() -> Any {
        ["to_float", value.unparse()]
    }

    public func eval() -> Expression {
        evalEInt() ??
        evalEFloat() ??
        evalEBool() ??
        self
    }

    func evalEFloat() -> Expression? {
        if let value = value.eval() as? E.Float {
            return value
        }
        return nil
    }

    func evalEInt() -> Expression? {
        if let value = value.eval() as? E.Int {
            return E.Float(value: Float(value.value))
        }
        return nil
    }

    func evalEBool() -> Expression? {
        if let value = value.eval() as? E.Bool {
            return E.Float(value: value.value ? 1.0 : 0.0)
        }
        return nil
    }
}
