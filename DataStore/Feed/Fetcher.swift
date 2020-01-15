import Foundation
import CoreData

struct AnyError: Error {
    static var unknown = AnyError()
}

public class Fetcher {
    public static let shared = Fetcher()
    
    var isUpdating: Bool = false
    
    public func launch() {
        pullFromNetwork()
    }
    
    public func pullFromNetwork() {
        guard !isUpdating else { return }
        isUpdating = true
        Current.dataStore.loadStores { [weak self] in
            self?.loadData {
                self?.isUpdating = false
            }
        }
    }
}

private extension Fetcher {

    func loadData(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        let context = Current.dataStore.newBackgroundContext()
        
        dispatchGroup.enter()
        loadPosts(context: context) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadUsers(context: context) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadPhotos(context: context) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadAlbums(context: context) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            context.performAndWait {
                do {
                    if context.hasChanges {
                        try context.save()
                    }
                } catch {
                    print(error)
                    //Handle error
                }
            }
            completion()
        }
    }
    
    func loadPosts(context: NSManagedObjectContext, completion: @escaping () -> Void) {
        let posts = Resource<[NetworkPost]>(url: .posts)
        Current.webservice.load(resource: posts) { result in
            switch result {
            case .success(let posts):
                context.perform {
                    posts.forEach { CDPost.upsert($0, in: context) }
                    completion()
                }
            case .failure:
                // Handle error
                completion()
            }
        }

    }
    
    func loadUsers(context: NSManagedObjectContext, completion: @escaping () -> Void) {
        let users = Resource<[NetworkUser]>(url: .users)
        Current.webservice.load(resource: users) { result in
            switch result {
            case .success(let users):
                context.perform {
                    users.forEach { CDUser.upsert($0, in: context) }
                    completion()
                }
            case .failure:
                // Handle error
                completion()
            }
            
        }
    }
    
    func loadPhotos(context: NSManagedObjectContext, completion: @escaping () -> Void) {
        let photos = Resource<[NetworkPhoto]>(url: .photos)
        Current.webservice.load(resource: photos) { result in
            switch result {
            case .success(let photos):
                context.perform {
                    photos.forEach { CDPhoto.upsert($0, in: context) }
                    completion()
                }
            case .failure:
                // Handle error
                completion()
            }
        }
    }
    
    func loadAlbums(context: NSManagedObjectContext, completion: @escaping () -> Void) {
        let albums = Resource<[NetworkAlbum]>(url: .albums)
        Current.webservice.load(resource: albums) { result in
            switch result {
            case .success(let albums):
                context.perform {
                    albums.forEach { CDAlbum.upsert($0, in: context) }
                    completion()
                }
            case .failure:
                // Handle error
                completion()
            }
        }
    }
}
