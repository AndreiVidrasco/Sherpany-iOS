import Foundation

public protocol PostsObserverDelegate: AnyObject {
    func update(diff: CollectionDifference<FeedPostModel>)
}

public class PostsObserver {
    public weak var delegate: PostsObserverDelegate?
    private lazy var observer = CoreDataObserver<CDPost, FeedPostModel>(
        mapObject: FeedPostModel.init,
        didChange: { [weak self] change in self?.delegate?.update(diff: change) }
    )
    
    public init() {}
    
    public func search(text: String) {
        if text.isEmpty {
            observer.predicate = nil
        } else {
            observer.predicate = NSPredicate(format: "title contains[cd] %@ OR user.email contains[cd] %@", text, text)
        }
    }
        
    public var currentObjects: [FeedPostModel] { observer.currentObjects }
}
