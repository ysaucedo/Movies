//
//  Show+CoreDataProperties.swift
//  Movies Yair
//
//  Created by Yair Saucedo on 20/11/21.
//
//

import Foundation
import CoreData


extension Serie {
    
    @nonobjc public class func fetchRequestById(id: Int32, category: Category) -> NSFetchRequest<Serie> {
        //return NSFetchRequest<Show>(entityName: "Show")
        let predicate = NSPredicate(format: "category == '\(category)' AND id == '\(id)'")
        let fetchRequest = NSFetchRequest<Serie>(entityName: "Serie")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = predicate
        return fetchRequest
    }

    @nonobjc public class func fetchRequest(category:Category) -> NSFetchRequest<Serie> {
        //return NSFetchRequest<Show>(entityName: "Show")
        let predicate = NSPredicate(format: "category == '\(category)'")
        let fetchRequest = NSFetchRequest<Serie>(entityName: "Serie")
        fetchRequest.predicate = predicate
        return fetchRequest
    }

    @nonobjc public class func fetchRequestFilter(category:Category, search:String) -> NSFetchRequest<Serie> {
        //return NSFetchRequest<Show>(entityName: "Show")
        let predicate = NSPredicate(format: "category == '\(category)' AND name CONTAINS[c] '\(search)'")
        let fetchRequest = NSFetchRequest<Serie>(entityName: "Serie")
        fetchRequest.predicate = predicate
        return fetchRequest
    }

    
    @NSManaged public var backdrop_path: String!
    @NSManaged public var category: String
    @NSManaged public var first_air_date: String!
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var original_language: String
    @NSManaged public var original_name: String
    @NSManaged public var overview: String
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String!
    @NSManaged public var vote_average: Double
    @NSManaged public var vote_count: Int32

}

