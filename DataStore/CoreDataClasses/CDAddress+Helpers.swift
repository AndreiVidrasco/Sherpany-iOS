import Foundation
import CoreData

extension CDAddress {
    static func upsert(_ address: NetworkUser.Address, for user: CDUser, in context: NSManagedObjectContext) -> CDAddress {
        return createOrGet(from: user.address, in: context) {
            let newGeo = CDGeo.upsert(address.geo, for: $0, in: context)
            if $0.city != address.city { $0.city = address.city }
            if $0.street != address.street { $0.street = address.street }
            if $0.suite != address.suite { $0.suite = address.suite }
            if $0.zipcode != address.zipcode { $0.zipcode = address.zipcode }
            if $0.user != user { $0.user = user }
            if $0.geo != newGeo { $0.geo = newGeo }
        }
    }
}
