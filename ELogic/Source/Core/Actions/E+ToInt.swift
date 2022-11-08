//
//  MToInt.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

extension E {
    struct ToInt {
        let value: Expression

        init(value: Expression) {
            self.value = value
        }
    }
}

extension E.ToInt: Expression {
    func unparse() -> Any {
        ["to_int", value.unparse()]
    }

    func eval(_ context: E.Context) throws -> Expression {
        do {
            if let int = try evalEInt(context) {
                return int
            }
            if let float = try evalEFloat(context) {
                return float
            }
            if let bool = try evalEBool(context) {
                return bool
            }

        } catch let error as E.Error {
            throw E.Error.parseError(.init(parent: error,
                                           input: "To Int",
                                           level: error.level + 1))
        }
        throw E.Error.wrongArgument(.init(parent: nil,
                                          input: unparse(),
                                          level: 0))
    }

    func evalEFloat(_ context: E.Context) throws -> Expression? {
        if let value = try value.eval(context) as? E.Float {
            return E.Int(value: Int(value.value))
        }
        return nil
    }

    func evalEInt(_ context: E.Context) throws -> Expression? {
        if let value = try value.eval(context) as? E.Int {
            return value
        }
        return nil
    }

    func evalEBool(_ context: E.Context) throws -> Expression? {
        if let value = try value.eval(context) as? E.Bool {
            return E.Float(value: value.value ? 1.0 : 0.0)
        }
        return nil
    }
}
