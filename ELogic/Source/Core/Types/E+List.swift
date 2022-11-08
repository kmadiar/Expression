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
    func eval(_ context: E.Context) throws -> Expression {
        do {
            return E.List(value: try value.map { try $0.eval(context) })
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: value,
                                           level: error.level + 1))
        }
    }

    func unparse() -> Any {
        ["list", value.map { $0.unparse() }]
    }
}
