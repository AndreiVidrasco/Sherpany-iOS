import UIKit

extension UITableView {
    func applyChanges<T>(diff: CollectionDifference<T>) {
        var deletedIndexPaths = [IndexPath]()
        var insertedIndexPaths = [IndexPath]()
        
        for change in diff {
            switch change {
            case let .remove(offset, _, _):
                deletedIndexPaths.append(IndexPath(row: offset, section: 0))
            case let .insert(offset, _, _):
                insertedIndexPaths.append(IndexPath(row: offset, section: 0))
            }
        }
        self.performBatchUpdates({
            self.deleteRows(at: deletedIndexPaths, with: .fade)
            self.insertRows(at: insertedIndexPaths, with: .right)
        }, completion: { _ in })
    }
}
