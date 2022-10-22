//
//  MBool.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public extension E {
    struct Bool {
        public let value: Swift.Bool

        public init(value: Swift.Bool) {
            self.value = value
        }
    }
}

extension E.Bool: Expression {
    public func unparse() -> Any {
        value
    }

    public func eval() -> Expression {
        self
    }
}

extension E.Bool {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value || rhs.value)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value && rhs.value)
    }
}
