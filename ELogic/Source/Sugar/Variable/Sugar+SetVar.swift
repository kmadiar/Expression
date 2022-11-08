//
//  Sugar+SetVar.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 06.11.2022.
//

import Foundation

/// Sugar operation type representing setting variable
public extension Sugar {
    struct SetVar {
        public let left: String
        public let right: SugarExpression

        public init(left: String, right: SugarExpression) {
            self.left = left
            self.right = right
        }
    }
}

// MARK: - Expression conformance
extension Sugar.SetVar: SugarExpression {
    public func deSugar() throws -> Expression {
        E.SetVar(left: left, right: try right.deSugar())
    }

    // TODO: - dummy implementations
    public func deSugarC() -> String {
        ""
    }
}
