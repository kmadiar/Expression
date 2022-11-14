//
//  Sugar+If.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 14.11.2022.
//

import Foundation

extension Sugar {
    public struct If {
        public let condition: SugarExpression
        public let mainBranch: SugarExpression
        public let altBranch: SugarExpression

        public init(condition: SugarExpression, mainBranch: SugarExpression, altBranch: SugarExpression) {
            self.condition = condition
            self.mainBranch = mainBranch
            self.altBranch = altBranch
        }
    }
}

extension Sugar.If: SugarExpression {
    public func deSugar() throws -> Expression {
        E.If(condition: try condition.deSugar(),
             mainBranch: try mainBranch.deSugar(),
             altBranch: try altBranch.deSugar())
    }
}
