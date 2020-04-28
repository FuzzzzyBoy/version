//
//  main.swift
//  version
//
//  Created by Kirill Shakhansky on 13.04.2020.
//  Copyright © 2020 Kirill Shakhansky. All rights reserved.
//

import ArgumentParser

struct CalculateVersionString: ParsableCommand {

    @Argument(help: "String to count the characters of") var argument: String

    func run() throws {
        let splitted = argument.split(separator: " ").map { String($0) }
        guard splitted.count == 2,
            let versionNumber = getVersionNumber(from: splitted.first!),
            let buildNumber = getBuildNumber(from: splitted.last!)
            else { return printError() }
        print(versionNumber + buildNumber)
    }

    private func printError() {
        print("arguments must be in format like x.x.x (x) where x is a number")
    }

    private func getVersionNumber(from string: String) -> Int? {
        let splitted = string.split(separator: ".")
        guard splitted.count == 3,
            let major = Int(splitted[0]),
            let minor = Int(splitted[1]),
            let bugfix = Int(splitted[2])
            else { return nil }

        return major * 100000 + minor * 10000 + bugfix * 1000
    }

    private func getBuildNumber(from string: String) -> Int? {
        return Int(string[1])
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

CalculateVersionString.main()
