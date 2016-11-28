//
//  PersonMO+CoreDataProperties.swift
//  TestTable
//
//  Created by wyl on 2016/11/28.
//  Copyright © 2016年 ts. All rights reserved.
//

import Foundation
import CoreData


extension PersonMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonMO> {
        return NSFetchRequest<PersonMO>(entityName: "Person");
    }
    static let ApplicationSupportDirectory = FileManager().urls(for: .applicationSupportDirectory,
                                                                in: .userDomainMask).first!
    static let StoreURL = ApplicationSupportDirectory.appendingPathComponent("Acquaintance.sqlite")
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var photo: NSData?

}
