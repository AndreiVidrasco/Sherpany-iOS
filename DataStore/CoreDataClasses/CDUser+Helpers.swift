import Foundation
import CoreData

extension CDUser {
    @discardableResult
    static func upsert(_ networkUser: NetworkUser, in context: NSManagedObjectContext) -> CDUser {
        return lookup(networkUser, in: context) {
            let newCompany = CDCompany.upsert(networkUser.company, for: $0, in: context)
            let newAddress = CDAddress.upsert(networkUser.address, for: $0, in: context)
            
            if $0.name != networkUser.name { $0.name = networkUser.name }
            if $0.username != networkUser.username { $0.username = networkUser.username }
            if $0.email != networkUser.email { $0.email = networkUser.email }
            if $0.phone != networkUser.phone { $0.phone = networkUser.phone }
            if $0.website != networkUser.website { $0.website = networkUser.website }
            if $0.company != newCompany { $0.company = newCompany }
            if $0.address != newAddress { $0.address = newAddress }
        }
    }
}
