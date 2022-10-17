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
extension MInt: AdditiveArithmetic {
    public static func - (lhs: MInt, rhs: MInt) -> MInt {
        .init(value: lhs.value - rhs.value)
    }

    public static func + (lhs: MInt, rhs: MInt) -> MInt {
        .init(value: lhs.value + rhs.value)
    }

    public static var zero: MInt {
        .init(value: 0)
    }
}

// MARK: - add multiplication
public extension MInt {
    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }
}
