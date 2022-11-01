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
    struct TailList {
        public let value: SugarExpression

        public init(value: SugarExpression) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.TailList: SugarExpression {
    func takeValue() throws -> E.Int {
        let value = try value.deSugar().eval() as! E.List
        return try value.value.last!.eval() as! E.Int
    }

    // TODO: - add errors, remove force unwrap
    public func deSugar() -> Expression {
        try! takeValue()
    }

    // TODO: - dummy implementations
    public func deSugarC() -> String {
        let value = try! takeValue()
        return Sugar.Integer(value: value.value).deSugarC()
    }
}