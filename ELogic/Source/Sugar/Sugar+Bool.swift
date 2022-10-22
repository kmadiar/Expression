//
//  SugarBool.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

public extension Sugar {
    struct Bool {
        public let value: Swift.Bool

        public init(value: Swift.Bool) {
            self.value = value
        }
    }
}

extension Sugar.Bool: SugarExpression {
    public func deSugarC() -> String {
        value ? "true" : "false"
    }

    public func deSugar() -> Expression {
        E.Bool(value: value)
    }
}

extension Sugar.Bool {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value || rhs.value)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value && rhs.value)
    }
}
