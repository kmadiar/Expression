//
//  E+List.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 19.10.2022.
//

import Foundation

//[append, list, element], [head, list], [tail, list], [generate_range, from, to]
extension E {
    struct List {
        public let value: Array<Expression>

        public init(value: Array<Expression>) {
            self.value = value
        }
    }
}

extension E.List: Expression {
    func eval() throws -> Expression {
        // TODO: - add error propagation
        E.List(value: try value.map { try $0.eval() })
    }

    func unparse() -> Any {
        ["list", value.map { $0.unparse() }]
    }
}
