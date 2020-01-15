import UIKit
import DataStore

protocol DetailsDataProviding {
    func setup(model: PostId)
    var title: String? { get }
    var body: String? { get }
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func detailsHeaderModel(in section: Int) -> DetailsHeaderModel
    func photoUrl(at indexPath: IndexPath) -> URL
    func photoThumbnail(at indexPath: IndexPath) -> URL
}

protocol DetailsDataProviderDelegate: AnyObject {
    func reloadSection(index: Int)
}

final class DetailsDataProvider: DetailsDataProviding {
    var model: DetailPostModel?
    weak var delegate: DetailsDataProviderDelegate?
    private var showingSection: [Bool] = []
    
    func setup(model: PostId) {
        self.model = DetailPostModel(id: model.id)
        self.showingSection = [Bool].init(repeating: false, count: numberOfSections)
    }
    
    func photo(at indexPath: IndexPath) -> DetailPostModel.Photo {
        guard let photo = model?.albums[indexPath.section].photo[indexPath.row] else {
            fatalError("Could not find the model at indexPath: \(indexPath)")
        }
        return photo
    }
}

extension DetailsDataProvider {
    var title: String? { model?.title }
    var body: String? { model?.body }
    var numberOfSections: Int { model?.albums.count ?? 0 }
    
    func numberOfRows(in section: Int) -> Int {
        if showingSection[section] {
            return model?.albums[section].photo.count ?? 0
        } else {
            return 0
        }
    }
    
    func photoUrl(at indexPath: IndexPath) -> URL {
        return photo(at: indexPath).url
    }
    
    func photoThumbnail(at indexPath: IndexPath) -> URL {
        return photo(at: indexPath).thumbnail
    }
    
    func detailsHeaderModel(in section: Int) -> DetailsHeaderModel {
        let title = model?.albums[section].title ?? ""
        return DetailsHeaderModel(title: title, showing: showingSection[section]) { [weak self] in
            self?.showingSection[section].toggle()
            self?.delegate?.reloadSection(index: section)
        }
    }
    
}
