import Foundation
import CoreData

extension CDPhoto {
    @discardableResult
    static func upsert(_ networkPhoto: NetworkPhoto, in context: NSManagedObjectContext) -> CDPhoto {
        return lookup(networkPhoto, in: context) {
            if $0.album?.id != Int64(networkPhoto.albumId) { $0.album = .lookup(networkPhoto.albumId, in: context) }
            if $0.title != networkPhoto.title { $0.title = networkPhoto.title }
            if $0.url != networkPhoto.url.absoluteString { $0.url = networkPhoto.url.absoluteString }
            if $0.thumbnailUrl != networkPhoto.thumbnailUrl.absoluteString { $0.thumbnailUrl = networkPhoto.thumbnailUrl.absoluteString }
        }
    }
}
