//
//  FavoriteConfig.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 22/09/21.
//

import Foundation
import CoreData

class FavoriteConfig {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorites")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    private func newTaskContext() -> NSManagedObjectContext {
           let taskContext = persistentContainer.newBackgroundContext()
           taskContext.undoManager = nil
           taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
           return taskContext
       }
    func getAllMember(completion: @escaping(_ members: [FavGameModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var members: [FavGameModel] = []
                for result in results {
                    let member = FavGameModel(id: result.value(forKey: "id") as? Int,
                                              gameName: result.value(forKey: "gameName") as? String,
                                              gameDescription: result.value(forKey: "gameDescription") as? String,
                                              gameReleasedDate: result.value(forKey: "gameReleasedDate") as? String,
                                              gameImageThumbnail: result.value(forKey: "gameImageThumbnail") as? String,
                                              gameRating: result.value(forKey: "gameRating") as? Double)
                    members.append(member)
                }
                completion(members)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func getMember(_ id: Int, completion: @escaping(_ members: FavGameModel) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let member = FavGameModel(id: result.value(forKey: "id") as? Int,
                                              gameName: result.value(forKey: "gameName") as? String,
                                              gameDescription: result.value(forKey: "gameDescription") as? String,
                                              gameReleasedDate: result.value(forKey: "gameReleasedDate") as? String,
                                              gameImageThumbnail: result.value(forKey: "gameImageThumbnail") as? String,
                                              gameRating: result.value(forKey: "gameRating") as? Double)
                    completion(member)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func createMember(_ id: Int,
                      _ gameName: String,
                      _ gameDescription: String,
                      _ gameReleasedDate: String,
                      _ gameImageThumbnail: String,
                      _ gameRating: Double,
                      completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                let member = NSManagedObject(entity: entity, insertInto: taskContext)
                    member.setValue(id, forKeyPath: "id")
                    member.setValue(gameName, forKeyPath: "gameName")
                    member.setValue(gameDescription, forKeyPath: "gameDescription")
                    member.setValue(gameReleasedDate, forKeyPath: "gameReleasedDate")
                    member.setValue(gameImageThumbnail, forKeyPath: "gameImageThumbnail")
                    member.setValue(gameRating, forKeyPath: "gameRating")
                    do {
                        try taskContext.save()
                        completion()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
            }
        }
    }
    func deleteMember(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
            }
        }
    }
}
