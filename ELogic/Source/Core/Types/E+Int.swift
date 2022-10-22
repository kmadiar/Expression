//
//  MInt.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public extension E {
    struct Int {
        public let value: Swift.Int

        public init(value: Swift.Int) {
            self.value = value
        }
    }
}

extension E.Int: Expression {
    public func unparse() -> Any {
        value
    }

    public func eval() -> Expression {
        self
    }
}

// MARK: - Conform + / - Arithmetic
public extension E.Int {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }
}

// MARK: - add multiplication
public extension E.Int {
    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }
}
