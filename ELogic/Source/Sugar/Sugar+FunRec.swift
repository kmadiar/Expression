//
//  Sugar+FunRec.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 15.11.2022.
//

import Foundation

extension Sugar {
    public struct FunRec {
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

extension Sugar.FunRec: SugarExpression {
    public func deSugar() throws -> Expression {
        E.FunRecDefinition(name: name,
                           argumentNames: argumentNames,
                           body: try body.deSugar())
    }
}
