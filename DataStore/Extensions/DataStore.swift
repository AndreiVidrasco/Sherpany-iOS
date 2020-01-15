import CoreData

open class DataStoreObject: NSObject {
    static let shared: DataStoreObject = DataStoreObject()

    private(set) var hasLoadedStore: Bool = false
    
    fileprivate var container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container.viewContext
    }
    
    var managedModel: NSManagedObjectModel {
        return container.persistentStoreCoordinator.managedObjectModel
    }
    
    static var storageURL: URL {
        return NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathComponent(datastoreName)
            .appendingPathExtension("sqlite")
    }
    
    static let datastoreName = "DataStore"
    
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = self.container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
        
    init(description: DataStoreDescription = .default) {
        guard let model = description.model() else {
            fatalError("Could not find the CoreData model URL: \(description.dataStoreName)")
        }
        container = NSPersistentContainer(name: DataStoreObject.datastoreName, managedObjectModel: model)
        super.init()
    }
    
    func loadStores(completion: @escaping () -> Void) {
        guard !hasLoadedStore else {
            return completion()
        }
        container.loadPersistentStores { [weak self] (persistentStoreDescription, error) in
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                self.setInitialState()
                DispatchQueue.main.async {
                    if error == nil {
                        self.hasLoadedStore = true
                    }
                    completion()
                }
            }
        }
    }
    
    open func setInitialState() {
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
