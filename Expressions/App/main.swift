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
                  ("sugarInput", cWriter.makeEOutput)]

let inputs = listInputs + mathInputs

func handle(_ input: String,
            handleFunction: (String) -> String) {
    print("              ")
    print("______________")
    print("\(input).yml")
    print("              ")

    do {
        guard let content = try? ymlReader.read(fileName: input),
              let yaml = try? Yams.load(yaml: content) else {
            throw E.Error.badInput
        }

        let parser: ELogic.Parser = ParserImplementation()
        let expression = try parser.parse(yaml)

        let cOutput = handleFunction(expression.deSugarC())
        try cWriter.create(input, content: cOutput)

        print(expression.deSugar().eval())
        print(cOutput)
    } catch {
        print(error)
    }

    print("______________")
    print("              ")
}

listInputs.forEach(handle)
