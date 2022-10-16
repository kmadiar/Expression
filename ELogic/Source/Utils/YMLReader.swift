//
//  YMLReader.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 13.10.2022.
//

import Foundation

public final class YMLReader {
    public init() {}
    public func read(fileName: String = "input") throws -> String? {
        if let path = Bundle(for: YMLReader.self).path(forResource: fileName, ofType: "yml") {
            let url = URL(fileURLWithPath: path)
            let content = try String(contentsOf: url)
            return content.replacingOccurrences(of: "\n", with: "")
        }
        return nil
    }
}
