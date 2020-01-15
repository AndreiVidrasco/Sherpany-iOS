import Foundation
import CoreData

extension CDAlbum {
    @discardableResult
    static func upsert(_ networkAlbum: NetworkAlbum, in context: NSManagedObjectContext) -> CDAlbum {
        return lookup(networkAlbum, in: context) {
            if $0.title != networkAlbum.title { $0.title = networkAlbum.title }
            if $0.user?.id != Int64(networkAlbum.userId) { $0.user = .lookup(networkAlbum.userId, in: context) }
        }
    }
}
