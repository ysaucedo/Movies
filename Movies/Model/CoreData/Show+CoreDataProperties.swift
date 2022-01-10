//
//  Show+CoreDataProperties.swift
//  Movies Yair
//
//  Created by Yair Saucedo on 20/11/21.
//
//

import Foundation
import CoreData


extension Show {
    
    @nonobjc public class func fetchRequestById(id: Int32, category: Category) -> NSFetchRequest<Show> {
        //return NSFetchRequest<Show>(entityName: "Show")
        let predicate = NSPredicate(format: "category == '\(category)' AND id == '\(id)'")
        let fetchRequest = NSFetchRequest<Show>(entityName: "Show")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = predicate
        return fetchRequest
    }

    @nonobjc public class func fetchRequest(category:Category) -> NSFetchRequest<Show> {
        //return NSFetchRequest<Show>(entityName: "Show")
        let predicate = NSPredicate(format: "category == '\(category)'")
        let fetchRequest = NSFetchRequest<Show>(entityName: "Show")
        fetchRequest.predicate = predicate
        return fetchRequest
    }

    @nonobjc public class func fetchRequestFilter(category:Category, search:String) -> NSFetchRequest<Show> {
        //return NSFetchRequest<Show>(entityName: "Show")
        let predicate = NSPredicate(format: "category == '\(category)' AND title CONTAINS[c] '\(search)'")
        let fetchRequest = NSFetchRequest<Show>(entityName: "Show")
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    
    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String!
    @NSManaged public var genre_ids: [Int]
    @NSManaged public var id: Int32
    @NSManaged public var original_language: String
    @NSManaged public var overview: String
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String!
    @NSManaged public var release_date: String
    @NSManaged public var title: String
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Double
    @NSManaged public var vote_count: Int32
    @NSManaged public var category: String

}

