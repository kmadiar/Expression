//
//  E+Do.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.11.2022.
//

import Foundation

extension E {
    /// Core type representing scope
    struct Do {
        public let values: Array<Expression>

        public init(values: Array<Expression>) {
            self.values = values
        }
    }
}

extension E.Do: Expression {
    func eval(_ context: E.Context) throws -> Expression {
        do {
            let localContext = context.expand()
            let values = try values.map { try $0.eval(localContext) }
            guard let last = values.last else {
                throw E.Error.wrongArgumentsCount(.init(parent: nil,
                                                        input: values,
                                                        level: 0))
            }
            return last
        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: values,
                                           level: error.level + 1))
        }
    }

    func unparse() -> Any {
        ["list", values.map { $0.unparse() }]
    }
}
