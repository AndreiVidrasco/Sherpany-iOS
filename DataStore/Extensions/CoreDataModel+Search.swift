import Foundation
import CoreData

protocol Identifiable {
    var id: Int { get }
}

protocol SearchableManagedObjectModel {
    associatedtype NetworkIdentifiable
    var id: Int64? { get set }
    static func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription?
}

extension SearchableManagedObjectModel where Self: NSManagedObject, NetworkIdentifiable: Identifiable {
    static func lookup(
        _ identifier: NetworkIdentifiable,
        in context: NSManagedObjectContext,
        changes: @escaping (Self) -> Void = { _ in }) -> Self {
        return lookup(identifier.id, in: context, changes: changes)
    }

    static func lookup(_ id: Int, in context: NSManagedObjectContext, changes: @escaping (Self) -> Void = { _ in }) -> Self {
        var post: Self
        do {
            let request = fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            let fetched = try context.fetch(request)
            if let first = fetched.first as? Self {
                post = first
            } else {
                throw AnyError.unknown
            }
        } catch {
            let description = entity(in: context)!
            post = Self.init(entity: description, insertInto: context)
            post.id = Int64(id)
        }
        changes(post)
        
        return post
    }
}


extension CDPost: SearchableManagedObjectModel {
    typealias NetworkIdentifiable = NetworkPost
}
extension CDUser: SearchableManagedObjectModel {
    typealias NetworkIdentifiable = NetworkUser
}
extension CDAlbum: SearchableManagedObjectModel {
    typealias NetworkIdentifiable = NetworkAlbum
}
extension CDPhoto: SearchableManagedObjectModel {
    typealias NetworkIdentifiable = NetworkPhoto
}

extension NetworkPost: Identifiable {}
extension NetworkUser: Identifiable {}
extension NetworkAlbum: Identifiable {}
extension NetworkPhoto: Identifiable {}



