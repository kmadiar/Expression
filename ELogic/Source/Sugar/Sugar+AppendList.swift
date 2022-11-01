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
    func extractValues() throws -> [E.Int] {
        let left = try left.deSugar().eval() as! E.List
        let right = try right.deSugar().eval() as! E.Int

        return try left.value.map { try $0.eval() as! E.Int } + [right]
    }

    // TODO: - add errors, remove force unwrap
    public func deSugar() -> Expression {
        let values = try! extractValues()
        return E.List(value: values)
    }

    // TODO: - dummy implementations
    public func deSugarC() -> String {
        let values = try! extractValues()
            .map { Sugar.Integer(value: $0.value) }
        let list = Sugar.List(value: values)

        return list.deSugarC()
    }
}