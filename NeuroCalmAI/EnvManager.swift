//
//  EnvManager.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/24/24.
//

import Foundation

struct EnvManager {
    static func getAPIKey() -> String? {
        guard let url = Bundle.main.url(forResource: ".env", withExtension: nil) else {
            print("Configuration file not found.")
            return nil
        }

        do {
            let content = try String(contentsOf: url)
            let lines = content.components(separatedBy: .newlines)
            for line in lines {
                let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmedLine.isEmpty || trimmedLine.hasPrefix("#") {
                    continue
                }
                if trimmedLine.hasPrefix("OPENAI_API_KEY=") {
                    let key = trimmedLine.replacingOccurrences(of: "OPENAI_API_KEY=", with: "")
                    return key.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            print("API key configuration not found.")
            return nil
        } catch {
            print("Error reading configuration file.")
            return nil
        }
    }
}
