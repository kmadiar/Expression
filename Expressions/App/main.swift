//
//  main.swift
//  Expressions
//
//

import Foundation
import ELogic
import Yams

let inputs = ["input",
              "sugarInput"]

let ymlReader = YMLReader()
let cWriter = CWriter()

func handle(_ input: String) {
    print("              ")
    print("______________")
    print("\(input).yml")
    print("              ")

    do {
        guard let content = try? ymlReader.read(fileName: input),
              let yaml = try? Yams.load(yaml: content) else {
            throw MError.badInput
        }

        let parser: ELogic.Parser = ParserImplementation()
        let expression = try parser.parse(yaml)

        let cOutput = cWriter.makeCOutput(expression.deSugarC())
        try cWriter.create(input, content: cOutput)

        print(expression.deSugar().eval())
        print(cOutput)
    } catch {
        print(error)
    }

    print("______________")
    print("              ")
}

inputs.forEach(handle)
