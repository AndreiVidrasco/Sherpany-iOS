import CoreData

class CoreDataObserver<CoreDataObject: NSManagedObject, DataModel: Equatable>: NSObject, NSFetchedResultsControllerDelegate {
    
    // https://developer.apple.com/documentation/coredata/nsfetchedresultscontroller
    private var frc: NSFetchedResultsController<CoreDataObject>?
    private let context: NSManagedObjectContext
    let didChange: (CollectionDifference<DataModel>) -> Void
    let mapObject: (CoreDataObject) -> DataModel
    var currentObjects: [DataModel] { (frc?.fetchedObjects ?? []).map(mapObject) }
    var predicate: NSPredicate? {
        didSet {
            let previousValue = currentObjects
            frc?.fetchRequest.predicate = predicate
            try? frc?.performFetch()
            let newObjects = currentObjects
            let difference = newObjects.difference(from: previousValue, by: ==)
            didChange(difference)
        }
    }
    
    init(mapObject: @escaping (CoreDataObject) -> DataModel, didChange: @escaping (CollectionDifference<DataModel>) -> Void) {
        self.mapObject = mapObject
        self.didChange = didChange
        context = Current.dataStore.newBackgroundContext()
        super.init()
        setupObserver()
    }
    
    func setupObserver() {
        let fetchRequest = CoreDataObject.fetchRequest() as! NSFetchRequest<CoreDataObject>
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }

        frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                         managedObjectContext: context,
                                         sectionNameKeyPath: nil, cacheName: nil)
        frc?.delegate = self
        do {
            try frc?.performFetch()
            let _ = frc?.fetchedObjects
        }
        catch {
            print(error)
            //Handle error
        }
    }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith diff: CollectionDifference<NSManagedObjectID>) {
        diff.mapElements(convert).map(didChange)
    }
    
    func convert(objectId: NSManagedObjectID) -> DataModel {
        let coreDataElement = context.object(with: objectId) as! CoreDataObject
        return mapObject(coreDataElement)
    }
}
