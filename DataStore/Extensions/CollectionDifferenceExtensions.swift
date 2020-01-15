import Foundation

public extension CollectionDifference {
    func mapElements<ElementOfResult>(_ transform: (ChangeElement) throws -> ElementOfResult) rethrows -> CollectionDifference<ElementOfResult>? {
        let mapped: [CollectionDifference<ElementOfResult>.Change] = try self.map { current in
            switch current {
            case .insert(let offset, let element, let associatedWith):
                return try .insert(offset: offset, element: transform(element), associatedWith: associatedWith)
            case .remove(let offset, let element, let associatedWith):
                return try .remove(offset: offset, element: transform(element), associatedWith: associatedWith)
            }
        }
        return CollectionDifference<ElementOfResult>(mapped)
    }
}
