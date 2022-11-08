//
//  MFloat.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

extension E {
    struct Float {
        let value: Swift.Float

        init(value: Swift.Float) {
            self.value = value
        }
    }
}

extension E.Float: Expression {
    func unparse() -> Any {
        value
    }

    func eval(_ context: E.Context) -> Expression {
        self
    }
}

extension E.Float: NumericType {
    func isZero() -> Bool {
        value == .zero
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }

    static func / (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value / rhs.value)
    }

    static func > (lhs: Self, rhs: Self) -> Bool {
        lhs.value > rhs.value
    }
}
