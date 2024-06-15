//
//  Todo+CoreDataProperties.swift
//  LensCor
//
//  Created by Akash Saxena on 11/06/24.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var status: String?
    @NSManaged public var priority: String?
    @NSManaged public var location: String?

}

extension Todo : Identifiable {

}
