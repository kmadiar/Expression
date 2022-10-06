//
//  main.swift
//  Expressions
//
//

import Foundation
import ELogic

let x = MInt(x: 10)
let y = MInt(x: 12)

let exp = MAdd(x: x, y: y)

let exp2 = MAdd(x: MInt(x: 100), y: MInt(x: 200))

let exp3 = MMultiplication(x: exp, y: exp2)

print(exp3.eval())

