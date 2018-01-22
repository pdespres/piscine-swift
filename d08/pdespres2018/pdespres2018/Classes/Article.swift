//
//  Article.swift
//  pdespres2018
//
//  Created by Paul DESPRES on 1/18/18.
//

import CoreData

public class Article: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }
    
    @NSManaged public var titre: String?
    @NSManaged public var content: String?
    @NSManaged public var langue: String?
    @NSManaged public var image: NSData?
    @NSManaged public var dateCreation: NSDate?
    @NSManaged public var dateMod: NSDate?
    
    override public var description: String {
        return "Article: \(titre!) \(langue!) \(content!) \(dateMod!)"
    }
    
}

