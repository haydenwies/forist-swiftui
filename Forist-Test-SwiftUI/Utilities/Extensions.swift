//
//  Extensions.swift
//  Forist-Test-SwiftUI
//
//  Created by Hayden Wies on 2021-07-17.
//

import Foundation
import Firebase
import FirebaseAuth

// MARK: - Encodable

extension Encodable {
    
    func asDictionary() throws -> [String : Any] {
    
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
        else {
            throw NSError()
        }
        return dictionary
        
    }
    
    
}

// MARK: - Decodable

extension Decodable {
    
    init(fromDictionary: Any) throws {
        
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
        
    }
    
    
}

// MARK: - String

extension String {
    
    func splitString() -> [String] {
        
        var stringArray: [String] = []
        let trimmed = String(self.filter { !" \n\t\r".contains($0) })
        
        for (index, _) in trimmed.enumerated() {
            let prefixIndex = index + 1
            let substringPrefix = String(trimmed.prefix(prefixIndex)).lowercased()
            stringArray.append(substringPrefix)
        }
        
        return stringArray
        
    }
    
    func trimSpaces() -> String {
        let trimmedString = String(self).trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
    
    
}

