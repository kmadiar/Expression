//
//  E+Context.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.11.2022.
//

import Foundation

extension E {
    public class Environment {
        public init(bindings: [String : Expression]) {
            self.bindings = bindings
        }

        public var bindings: [String: Expression]

        public func addBinding(_ name: String, value: Expression) {
            bindings[name] = value
        }

        public func get(_ name: String) throws -> Expression {
            if let expression = bindings[name] {
                return expression
            }

            throw E.Error.variableNotFound(.init(parent: nil,
                                                 input: name,
                                                 level: 0))
        }
    }
}

extension E {
    public class Context {
        public init(variables: E.Environment,
                    parent: Context? = nil) {
            self.variables = variables
            self.parent = parent
        }

        public var variables: Environment
        public var parent: Context?

        public func expand() -> Context {
            Context(variables: .init(bindings: [:]), parent: self)
        }

        public func clone() -> Context {
            Context(variables: Environment(bindings: variables.bindings))
        }
    }
}
