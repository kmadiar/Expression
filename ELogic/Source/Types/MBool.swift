//
//  MBool.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public struct MBool {
    public let value: Bool

    public init(value: Bool) {
        self.value = value
    }
}

extension MBool: MExpression {
    public func eval() -> MExpression {
        self
    }
}

extension MBool {
    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value || rhs.value)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value && rhs.value)
    }
}
