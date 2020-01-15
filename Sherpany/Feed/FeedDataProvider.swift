import Foundation
import DataStore

protocol FeedDataProviding {
    var numberOfItems: Int { get }
    func model(at index: Int) -> PostCellModel
    func delete(at index: Int)
    func id(at index: Int) -> PostId
    func setup()
    func search(text: String)
}

protocol FeedDataProviderDelegate: AnyObject {
    func didChange(diff: CollectionDifference<Any>)
}

final class FeedDataProvider: FeedDataProviding {
    let observer = PostsObserver()
    weak var delegate: FeedDataProviderDelegate?
    var dataSource = [FeedPostModel]()

    var numberOfItems: Int { dataSource.count }
    
    func search(text: String) {
        observer.search(text: text)
    }
        
    func model(at index: Int) -> PostCellModel {
        let model = dataSource[index]
        return PostCellModel(title: model.text, subtitle: model.email)
    }
    
    func id(at index: Int) -> PostId {
        return PostId(id: dataSource[index].id)
    }
    
    func setup() {
        observer.delegate = self
        self.dataSource = observer.currentObjects
    }
    
    func delete(at index: Int) {
        dataSource[index].delete()
    }
}

extension FeedDataProvider: PostsObserverDelegate {
    func update(diff: CollectionDifference<FeedPostModel>) {
        self.dataSource = self.dataSource.applying(diff) ?? []
        if let mapped = diff.mapElements({ $0 as Any }) {
            self.delegate?.didChange(diff: mapped)
        }
    }
}
