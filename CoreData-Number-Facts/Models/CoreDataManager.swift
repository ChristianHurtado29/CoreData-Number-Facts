//
//  CoreDataManager.swift
//  CoreData-Number-Facts
//
//  Created by Christian Hurtado on 4/9/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    // implement singleton
    static let shared = CoreDataManager()
    private init() {}
    
    private var users = [User]() // User is a NSManageObject
    private var posts = [Post]()
    
    // we need to access the persistence container in app delegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // viewContext is of type NSManagedObjectContext
    
    // CRUD
    public func createUser(name: String, dob: Date) -> User{
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        //============================================
        // save changes to the NSMangedObjectContext
        //============================================
        // persistence - saving data
        // persistence: user defaults, documents directory, firebase, core data, (iCloud)
        // similar to saving to file manager
        
        do {
            try context.save()
        } catch {
            print("error saving user: \(error)")
        }
        return user
    }
    
    public func fetchUser() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest()) // fetchRequest() gets all the objects from Core Data
            // extra notes: we can use (NSPredicate) to sort and filter Core data objects during fetching
            // fetchRequest is of type NSFetchRequest
        } catch {
            print("fetching users error: \(error)")
        }
        return users
    }
}
