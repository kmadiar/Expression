//
//  main.swift
//  Expressions
//
//

import Foundation
import ELogic
import Yams

let cWriter = CWriter()
let ymlReader = YMLReader()

let listInputs = [("list", cWriter.makeListOutput),
                  ("appendList", cWriter.makeListOutput)]

let mathInputs = [("input", cWriter.makeEOutput),
                  ("input_error", cWriter.makeEOutput),
                  ("division_by_zero", cWriter.makeEOutput),
                  ("sugarInput", cWriter.makeEOutput),
                  ("letstar", cWriter.makeEOutput)]

let inputs = listInputs + mathInputs

var context = E.Context(variables: .init(bindings: [:]))

func handle(_ input: String,
            handleFunction: (String) -> String) {
    print("              ")
    print("______________")
    print("\(input).yml")
    print("              ")

    do {
        guard let content = try? ymlReader.read(fileName: input),
              let yaml = try? Yams.load(yaml: content) else {
            throw E.Error.badInput(.init(parent: nil,
                                         input: input, level: 0))
        }

        let parser: ELogic.Parser = ParserImplementation()
        let expression = try parser.parse(yaml)

        let cOutput = handleFunction(expression.deSugarC())
        try cWriter.create(input, content: cOutput)

        print(try expression.deSugar().eval(context))
        print(cOutput)
    } catch {
        print(error)
    }

    print("______________")
    print("              ")
}

inputs.forEach(handle)

let parser: ELogic.Parser = ParserImplementation()
while let input = readLine() {
    do {
        let yaml = try Yams.load(yaml: input)
        let parsed = try parser.parse(yaml)
        print(try parsed.deSugar().eval(context))
    } catch {
        print(error)
    }
}
