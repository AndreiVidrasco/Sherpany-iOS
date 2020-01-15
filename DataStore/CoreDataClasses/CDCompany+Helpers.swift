import Foundation
import CoreData

extension CDCompany {
    static func upsert(_ company: NetworkUser.Company, for user: CDUser, in context: NSManagedObjectContext) -> CDCompany {
        return createOrGet(from: user.company, in: context) {
            if $0.bs != company.bs { $0.bs = company.bs }
            if $0.catchPhrase != company.catchPhrase { $0.catchPhrase = company.catchPhrase }
            if $0.name != company.name { $0.name = company.name }
            if $0.user != user { $0.user = user }
        }
    }
}
