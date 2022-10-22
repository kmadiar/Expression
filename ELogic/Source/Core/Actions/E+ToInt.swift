//
//  MToInt.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public extension E {
    struct ToInt {
        public let value: Expression

        public init(value: Expression) {
            self.value = value
        }
    }
}

extension E.ToInt: Expression {
    public func unparse() -> Any {
        ["to_int", value.unparse()]
    }

    public func eval() -> Expression {
        evalEInt() ??
        evalEFloat() ??
        evalEBool() ??
        self
    }

    func evalEFloat() -> Expression? {
        if let value = value.eval() as? E.Float {
            return E.Int(value: Int(value.value))
        }
        return nil
    }

    func evalEInt() -> Expression? {
        if let value = value.eval() as? E.Int {
            return value
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
