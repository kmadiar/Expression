//
//  main.swift
//  Expressions
//
//

import Foundation
import ELogic
import Yams

do {
    guard let content = try? YMLReader().read(),
          let yaml = try? Yams.load(yaml: content) else {
        throw MError.badInput
    }

    let parser: Parser = ParserImplementation()

    let expression = try parser.parse(yaml)

    print(expression)
    print(expression.eval())
    print(expression.unparse())
} catch {
    print(error)
}
