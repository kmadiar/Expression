//
//  Sugar+Eq.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 14.11.2022.
//

import Foundation

public extension Sugar {
    struct Eq {
        public let left: SugarExpression
        public let right: SugarExpression

        public init(_ values: (left: SugarExpression, right: SugarExpression)) {
            self.init(left: values.left, right: values.right)
        }

        public init(left: SugarExpression, right: SugarExpression) {
            self.left = left
            self.right = right
        }
    }
}

// MARK: - Expression conformance
extension Sugar.Eq: SugarExpression {
    public func deSugar() throws -> Expression {
        E.Eq(left: try left.deSugar(), right: try right.deSugar())
    }
}
