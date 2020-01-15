import CoreData

private class DataStoreToken {
    static var bundle: Bundle {
        return Bundle(for: DataStoreToken.self)
    }
}

struct DataStoreDescription {
    let dataStoreName: String
    let bundle: Bundle
    
    func model() -> NSManagedObjectModel? {
        guard let url = bundle.url(forResource: dataStoreName, withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: url) else {
                return nil
        }
        return model
    }
    
    static let `default` = DataStoreDescription(dataStoreName: "SherpanyModel", bundle: DataStoreToken.bundle)
}
