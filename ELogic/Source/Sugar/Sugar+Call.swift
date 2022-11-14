//
//  Sugar+Call.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 13.11.2022.
//

import Foundation

extension Sugar {
    public struct Call {
        public init(function: SugarExpression, param: [SugarExpression]) {
            self.function = function
            self.param = param
        }

        public let function: SugarExpression
        public let param: [SugarExpression]
    }
}

extension Sugar.Call: SugarExpression {
    public func deSugar() throws -> Expression {
        E.Call(function: try function.deSugar(),
               parameter: try param.map { try $0.deSugar() })
    }
}
