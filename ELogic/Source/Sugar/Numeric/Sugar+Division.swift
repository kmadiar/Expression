//
//  Sugar+Devision.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 01.11.2022.
//

import Foundation

/// Sugar operation type representing division
public extension Sugar {
    struct Division {
        public enum TypeHelper: String {
            case int = "int_div"
            case float = "float_div"
            case generic = "div"
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
extension Sugar.Division: SugarExpression {
    public func deSugarC() -> String {
        "(\(left.deSugarC()) / \(right.deSugarC()))"
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
        return E.Division(left: try left.deSugar(),
                          right: try right.deSugar())
    }
}
