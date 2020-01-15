import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailsCollectionViewCell"

    @IBOutlet private var imageView: UIImageView!
    var url: URL?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setup(with url: URL) {
        self.url = url
        ImageDataProvider.load(url: url, completion: { [weak self] image, url in
            if self?.url == url {
                self?.imageView.image = image
            }
        })
    }
}
