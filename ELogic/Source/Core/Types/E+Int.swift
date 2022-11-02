//
//  MInt.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

extension E {
    struct Int {
        let value: Swift.Int

        init(value: Swift.Int) {
            self.value = value
        }
    }
}

extension E.Int: Expression {
    func unparse() -> Any {
        value
    }

    func eval() -> Expression {
        self
    }
}

extension E.Int {
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
