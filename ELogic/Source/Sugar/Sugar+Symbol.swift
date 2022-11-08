//
//  Sugar+Symbol.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.11.2022.
//

import Foundation

public extension Sugar {
    struct Symbol {
        public let value: String

        public init(value: String) {
            self.value = value
        }
    }
}

extension Sugar.Symbol: SugarExpression {
    public func deSugarC() -> String {
        "\(value)"
    }

    public func deSugar() -> Expression {
        E.Symbol(value: value)
    }
}
