//
//  Sugar+List.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 19.10.2022.
//

import Foundation

/// Sugar operation type representing list
public extension Sugar {
    struct List {
        public let value: [SugarExpression]

        public init(value: [SugarExpression]) {
            self.value = value
        }
    }
}

// MARK: - Expression conformance
extension Sugar.List: SugarExpression {
    public func deSugar() throws -> Expression {
        E.List(value: try value.map { try $0.deSugar() })
    }

    public func deSugarC() -> String {
        guard !value.isEmpty else {
            return "{}"
        }
        var value = value
        let first = value.removeFirst()
        var output = typeAnnotation() + " x[] = "
        output += "{" + "\(first.deSugarC())"

        output = value.reduce(output, { partialResult, next in
            partialResult + ", \(next.deSugarC())"
        })

        output += "}"

        return output
    }

    func typeAnnotation() -> String {
        // TODO: - add errors remove force unwrap
        let unwrapped = try! value.map { try $0.deSugar().eval() }
        if unwrapped as? Array<E.Int> != nil {
            return "int"
        }

        return ""
    }
}
