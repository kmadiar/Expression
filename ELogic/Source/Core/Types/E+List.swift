//
//  E+List.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 19.10.2022.
//

import Foundation

//[append, list, element], [head, list], [tail, list], [generate_range, from, to]
public extension E {
    struct List {
        public let value: Array<Expression>

        public init(value: Array<Expression>) {
            self.value = value
        }
    }
}

extension E.List: Expression {
    public func eval() -> Expression {
        E.List(value: value.map { $0.eval() })
    }

    public func unparse() -> Any {
        ["list", value.map { $0.unparse() }]
    }
}
