//
//  SugarMul.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

/// Sugar operation type representing multiplication
public extension Sugar {
    struct Multiplication {
        public enum TypeHelper: String {
            case int = "int_add"
            case float = "float_add"
            case generic = "add"
        }

        public let left: SugarExpression
        public let right: SugarExpression
        public var typeHelper: TypeHelper = .generic

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
extension Sugar.Multiplication: SugarExpression {
    public func deSugarC() -> String {
        "(\(left.deSugarC()) * \(right.deSugarC()))"
    }

    public func deSugar() throws -> Expression {
        let left, right: SugarExpression
        switch typeHelper {
        case .int:
            left = Sugar.ToInt(value: self.left)
            right = Sugar.ToInt(value: self.right)
        case .float:
            left = Sugar.ToFloat(value: self.left)
            right = Sugar.ToFloat(value: self.right)
        case .generic:
            left = self.left
            right = self.right
        }
        return E.Multiplication(left: try left.deSugar(),
                                right: try right.deSugar())
    }
}
