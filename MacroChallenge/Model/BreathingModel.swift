//
//  BreathingModel.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 15/10/20.
//

import Foundation
import CoreData

public class Breathing: NSManagedObject, Identifiable {
    @NSManaged public var name: String?
    @NSManaged public var inhale: Int16
    @NSManaged public var exhale: Int16
    @NSManaged public var hold1: Int16
    @NSManaged public var hold2: Int16
    @NSManaged public var sound: Bool
    @NSManaged public var haptic: Bool
    @NSManaged public var id: UUID
    @NSManaged public var favorite: Bool
}

extension Breathing {
    static func getAllBreathing() -> NSFetchRequest<Breathing> {
        let request:NSFetchRequest<Breathing> = Breathing.fetchRequest() as! NSFetchRequest<Breathing>
        
        let sortDescriptorFav = NSSortDescriptor(key: "favorite", ascending: false)
//        let sortDescroptorName = NSSortDescriptor(key: "name", ascending: true)
        
        
//        request.sortDescriptors = [sortDescriptorFav, sortDescroptorName]
        request.sortDescriptors = [sortDescriptorFav]

        
        return request
    }
}
