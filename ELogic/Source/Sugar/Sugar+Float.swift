//
//  SugarFloat.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

public extension Sugar {
    struct Float {
        public let value: Swift.Float

        public init(value: Swift.Float) {
            self.value = value
        }
    }
}

extension Sugar.Float: SugarExpression {
    public func deSugarC() -> String {
        "\(value)"
    }

    public func deSugar() -> Expression {
        MFloat(value: value)
    }
}

extension Sugar.Float {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }
}
