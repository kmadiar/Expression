//
//  Expression.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public enum E {}

public protocol Expression {
    func eval() throws -> Expression
    func unparse() -> Any
}
