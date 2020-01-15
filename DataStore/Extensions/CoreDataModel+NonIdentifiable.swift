import CoreData

protocol NonIdentifiableProperty {
    init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?)
    static func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription?
}


extension NonIdentifiableProperty {
    static func createOrGet(from current: Self?, in context: NSManagedObjectContext, changes: @escaping (Self) -> Void) -> Self {
        var newEntity: Self
        if let company = current {
            newEntity = company
        } else {
            let description = Self.entity(in: context)!
            newEntity = Self(entity: description, insertInto: context)
        }
        changes(newEntity)
        
        return newEntity
    }
}

extension CDCompany: NonIdentifiableProperty {}
extension CDGeo: NonIdentifiableProperty {}
extension CDAddress: NonIdentifiableProperty {}
