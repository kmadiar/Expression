//
//  Sugar+AppendList.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 19.10.2022.
//

import Foundation
// TODO: - WIP implementation
/// Sugar operation type representing list appending
public extension Sugar {
    struct AppendList {
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
extension Sugar.AppendList: SugarExpression {
    public func deSugar() throws -> Expression {
        guard let list = left as? Sugar.List else {
            throw E.Error.wrongArgument(.init(parent: nil,
                                              input: left,
                                              level: 0))
        }

        return try Sugar.List(value: list.value + [right]).deSugar()
    }
}
