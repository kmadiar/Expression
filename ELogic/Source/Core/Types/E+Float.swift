//
//  MFloat.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public extension E {
    struct Float {
        public let value: Swift.Float

        public init(value: Swift.Float) {
            self.value = value
        }
    }
}

extension E.Float: Expression {
    public func unparse() -> Any {
        value
    }

    public func eval() -> Expression {
        self
    }
}

extension E.Float {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }
}
