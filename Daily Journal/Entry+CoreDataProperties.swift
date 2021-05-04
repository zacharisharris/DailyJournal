//
//  Entry+CoreDataProperties.swift
//  Daily Journal
//
//  Created by Harris Zacharis on 4/5/21.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}

extension Entry : Identifiable {
    
    func month() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        if let dateToBeFormatted = date {
            let month = formatter.string(from: dateToBeFormatted).uppercased()
            return month
        }
        
        return "ERR"
    }
    
    func day() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        if let dateToBeFormatted = date {
            let day = formatter.string(from: dateToBeFormatted)
            return day
        }
        
        return "ERR"
    }

}
