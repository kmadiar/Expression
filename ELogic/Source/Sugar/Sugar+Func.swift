//
//  Sugar+Func.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 14.11.2022.
//

import Foundation

extension Sugar {
    public struct Func {
        public let name: String
        public let argumentNames: [String]
        public let body: SugarExpression

        public init(name: String, argumentNames: [String], body: SugarExpression) {
            self.name = name
            self.argumentNames = argumentNames
            self.body = body
        }
    }
}

extension Sugar.Func: SugarExpression {
    public func deSugar() throws -> Expression {
        E.SetVar(left: name,
                 right: E.LambdaDefinition(variable: argumentNames,
                                           body: try body.deSugar()))
    }
}
