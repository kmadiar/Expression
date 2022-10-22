//
//  Expression.swift
//  Expressions
//
//  Created by Kostiantyn Madiar on 06.10.2022.
//

import Foundation

public enum E {}

public protocol Expression {
    func eval() -> Expression
    func unparse() -> Any
}
