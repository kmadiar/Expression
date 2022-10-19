//
//  CWriter.swift
//  ELogic
//
//  Created by Kostiantyn Madiar on 19.10.2022.
//

import Foundation

public final class CWriter {
    public init() {}

    public func makeEOutput(_ input: String) -> String {
    """
    #include <stdio.h>

    int main() {
        int num = \(input);

        printf("your result is %d", num);
    }
    """
    }

    public func makeListOutput(_ input: String) -> String {
    """
    #include <stdio.h>

    int main() {
        \(input);
    }
    """
    }

    public func create(_ fileName: String, content: String) throws {
        let filePath = NSHomeDirectory() + "/Documents/" + fileName + ".c"
        let url = URL(fileURLWithPath: filePath)
        try content.write(to: url, atomically: true, encoding: .utf8)
    }
}
