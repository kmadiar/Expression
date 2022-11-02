//
//  SugarExpression.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 18.10.2022.
//

import Foundation

/// Protocol representing high level expressions
public protocol SugarExpression {
    /// Converts high level expression to Core level expression
    func deSugar() throws -> Expression
    func deSugarC() -> String
}

public enum Sugar {}
