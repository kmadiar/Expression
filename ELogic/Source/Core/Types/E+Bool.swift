//
//  MBool.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

extension E {
    struct Bool {
        let value: Swift.Bool

        init(value: Swift.Bool) {
            self.value = value
        }
    }
}

extension E.Bool: Expression {
    func unparse() -> Any {
        value
    }

    func eval() -> Expression {
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
