//
//  SugarInt.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

public extension Sugar {
    struct Integer {
        public let value: Swift.Int

        public init(value: Swift.Int) {
            self.value = value
        }
    }
}

extension Sugar.Integer: SugarExpression {
    public func deSugarC() -> String {
        "\(value)"
    }

    public func deSugar() -> Expression {
        E.Int(value: value)
    }
}

// MARK: - add addition
extension Sugar.Integer {
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }
}

// MARK: - add multiplication
public extension Sugar.Integer {
    static func * (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value * rhs.value)
    }
}
