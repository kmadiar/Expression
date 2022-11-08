//
//  E+Numeric.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 05.11.2022.
//

import Foundation

protocol Operation {}
protocol BinaryOperation: Operation {
    var left: Expression { get }
    var right: Expression { get }
}

protocol UnaryOperation: Operation {
    var value: Expression { get }
}

protocol NumericType {
    static func +(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    func isZero() -> Bool
}
