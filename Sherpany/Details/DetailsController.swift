import UIKit

final class DetailsController: UIViewController, StoryboardLoadable {
    var dataProvider: DetailsDataProviding!
    @IBOutlet private var collectionView: UICollectionView?
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var bodyLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - DetailsHandleable
    
    func setup(model: PostId) {
        self.dataProvider.setup(model: model)
        self.setupUI()
    }
}

private extension DetailsController {
    func setupUI() {
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        collectionView?.reloadData()
        self.titleLabel?.text = dataProvider.title
        self.bodyLabel?.text = dataProvider.body
    }
}

extension DetailsController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.identifier, for: indexPath)
        let model = dataProvider.photoThumbnail(at: indexPath)
        (cell as? DetailsCollectionViewCell)?.setup(with: model)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailsCollectionViewHeader.identifier, for: indexPath)
            let model = dataProvider.detailsHeaderModel(in: indexPath.section)
            (header as? DetailsCollectionViewHeader)?.setup(with: model)
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}

extension DetailsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = dataProvider.photoUrl(at: indexPath)
        let viewController = ImageViewBuilder.create(url: photo)
        present(viewController, animated: true, completion: nil)
    }
}

extension DetailsController: DetailsDataProviderDelegate {
    func reloadSection(index: Int) {
        collectionView?.reloadSections(IndexSet(integer: index))
    }
}
