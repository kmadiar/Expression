//
//  MError.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 16.10.2022.
//

import Foundation

public extension E {
    enum Error: Swift.Error {
        case wrongArgumentsCount
        case emptyList
        case unknownOperation
        case badInput
    }
}

extension E.Error: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .wrongArgumentsCount:
            return "argumenes count is incorrect for operation"
        case .emptyList:
            return "empty lists aren't supported"
        case .unknownOperation:
            return "unknown keyword"
        case .badInput:
            return "Invalid input"
        }
    }
}
