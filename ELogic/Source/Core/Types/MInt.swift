//
//  MInt.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public struct MInt {
    public let value: Int

    public init(value: Int) {
        self.value = value
    }
}

extension MInt: Expression {
    public func unparse() -> Any {
        value
    }

    public func eval() -> Expression {
        self
    }
}

// MARK: - Conform + / - Arithmetic
public extension MInt {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }
}

// MARK: - add multiplication
public extension MInt {
    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }
}
