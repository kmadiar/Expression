//
//  SugarLetStar.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 08.11.2022.
//

import Foundation

/// Sugar operation type representing let star
public extension Sugar {
    struct LetStar {
        public let bindings: [(String, SugarExpression)]
        public let body: SugarExpression

        public init(bindings: [(String, SugarExpression)], body: SugarExpression) {
            self.bindings = bindings
            self.body = body
        }
    }
}

extension Sugar.LetStar: SugarExpression {
    public func deSugar() throws -> Expression {

        let reversed = Array(bindings.reversed())

        var initial = Sugar.Let(name: reversed[0].0,
                                value: reversed[0].1,
                                body: body)

        for index in 1..<reversed.count {
            initial = Sugar.Let(name: reversed[index].0,
                                value: reversed[index].1, body: initial)
        }

        return try initial.deSugar()
    }

    public func deSugarC() -> String {
        "" // TODO: - add implementation
    }
}
