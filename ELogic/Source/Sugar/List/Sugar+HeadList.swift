//
//  Sugar+HeadList.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 19.10.2022.
//

import Foundation

// TODO: - WIP implementation
/// Sugar operation type representing list appending
public extension Sugar {
    struct HeadList {
        public let value: SugarExpression

        public init(value: SugarExpression) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.HeadList: SugarExpression {
    public func deSugar() throws -> Expression {
        guard let list = value as? Sugar.List else {
            throw E.Error.wrongArgument(.init(parent: nil,
                                              input: value,
                                              level: 0))
        }
        guard let last = list.value.first else {
            throw E.Error.emptyList(.init(parent: nil,
                                          input: value,
                                          level: 0))
        }
        return try last.deSugar()
    }

    // TODO: - dummy implementations
    public func deSugarC() -> String {
        ""
    }
}
