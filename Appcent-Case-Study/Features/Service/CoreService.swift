

import Foundation
import UIKit
import CoreData

final class CoreService{
    static let shared = CoreService()
    
    var managedContext:NSManagedObjectContext
    
    init?(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        managedContext = appDelegate.persistentContainer.viewContext
    }
    func allFavTrackList()->[NSManagedObject]{
        
        var fetchItemResults:[NSManagedObject] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TrackEntity")
        
        do{
            fetchItemResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
        }
        catch let error{
            print(error.localizedDescription)
        }
        return fetchItemResults
        
    }
    func checkIfItemExist(trackId: Int?) -> Bool {

        guard let trackId else {return false}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TrackEntity")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "trackId == %d" ,trackId)

        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    func deleteFavTrack(trackId:Int?){
        guard let trackId else {return}

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TrackEntity")
        fetchRequest.predicate = NSPredicate(format: "trackId == %d",trackId)
        do{
            let recordToDelete = try! managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in recordToDelete{

                managedContext.delete(item)
            }
            try managedContext.save()
        }
        catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
        //managedContext.delete()
    }
    func addFavTrack(trackId:Int?,trackCover:String?){
        guard let trackId else {return}
        
        let entity = NSEntityDescription.entity(forEntityName: "TrackEntity", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(trackId, forKey: "trackId")
        item.setValue(trackCover, forKey: "trackCover")
        do{try managedContext.save()}
        catch let error{
            print("Error while saving favorites")
        }
    }
}
