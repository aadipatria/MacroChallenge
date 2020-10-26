//
//  EmergencyModel.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 23/10/20.
//

import Foundation
import CoreData

public class Emergency: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var number: String?
}

extension Emergency {
    static func getAllEmergency() -> NSFetchRequest<Emergency> {
        let request:NSFetchRequest<Emergency> = Emergency.fetchRequest() as! NSFetchRequest<Emergency>
        
        request.sortDescriptors = []
        
        return request
    }
}
