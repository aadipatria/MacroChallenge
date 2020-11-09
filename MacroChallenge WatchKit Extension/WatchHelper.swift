//
//  WatchHelper.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 09/11/20.
//

import Foundation

class Storage: NSObject {
    static func archive(object: [[String]]) -> Data {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            return data
        } catch {
            fatalError("archive failed, can't encode data: \(error)")
        }
    }
    
    static func unarchive(data: Data) -> [[String]] {
        do {
            guard let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [[String]] else {
                return [[]]
            }
            return array
        } catch {
            fatalError("unarchived failed: \(error)")
        }
    }
    
    static func userDefault(data: Data) -> [[String]] {
        return Storage.unarchive(data: data)
    }
}
