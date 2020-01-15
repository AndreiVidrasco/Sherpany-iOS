import Foundation
import CoreData

extension CDPost {
    @discardableResult
    static func upsert(_ networkPost: NetworkPost, in context: NSManagedObjectContext) -> CDPost {
        return lookup(networkPost, in: context) {
            if $0.body != networkPost.body { $0.body = networkPost.body }
            if $0.title != networkPost.title { $0.title = networkPost.title }
            if $0.user?.id != Int64(networkPost.userId) { $0.user = CDUser.lookup(networkPost.userId, in: context) }
        }
    }
}
