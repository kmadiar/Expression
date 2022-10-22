//
//  Sugar+Sum.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

/// Sugar operation type representing addition
public extension Sugar {
    struct Sum {
        public let values: [SugarExpression]

        public init(_ values: [SugarExpression]) {
            self.values = values
        }
    }
}

// MARK: - Expression conformance
extension Sugar.Sum: SugarExpression {
    func eval() -> SugarExpression {
        guard !values.isEmpty else {
            return self
        }

        var values = values
        var output = values.removeFirst()

        while !values.isEmpty {
            output = Sugar.Add(left: output, right: values.removeFirst())
        }

        return output
    }

    public func deSugarC() -> String {
        eval().deSugarC()
    }

    public func deSugar() -> Expression {
        eval().deSugar()
    }
}
