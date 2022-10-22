//
//  SugarSubstract.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

/// Sugar operation type representing subtraction
public extension Sugar {
    struct Subtract {
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
extension Sugar.Subtract: SugarExpression {
    public func deSugarC() -> String {
        "(\(left.deSugarC()) - \(right.deSugarC()))"
    }

    public func deSugar() -> Expression {
        E.Add(left: left.deSugar(),
              right: Sugar.Neg(value: right).deSugar())
    }
}
