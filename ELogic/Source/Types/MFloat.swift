//
//  MFloat.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public struct MFloat {
    public let value: Float

    public init(value: Float) {
        self.value = value
    }
}

extension MFloat: MExpression {
    public func unparse() -> Any {
        value
    }

    public func eval() -> MExpression {
        self
    }
}

extension MFloat {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }
}
