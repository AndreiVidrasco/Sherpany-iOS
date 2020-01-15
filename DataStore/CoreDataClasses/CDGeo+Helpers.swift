import Foundation
import CoreData

extension CDGeo {
    static func upsert(_ geo: NetworkUser.Geo, for address: CDAddress, in context: NSManagedObjectContext) -> CDGeo {
        return createOrGet(from: address.geo, in: context) {
            if $0.lat != geo.lat { $0.lat = geo.lat }
            if $0.long != geo.lng { $0.long = geo.lng }
            if $0.address != address { $0.address = address }
        }
    }
}
