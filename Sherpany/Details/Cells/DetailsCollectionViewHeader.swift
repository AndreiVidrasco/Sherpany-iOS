import UIKit

class DetailsCollectionViewHeader: UICollectionReusableView {
    static let identifier = "DetailsCollectionViewHeader"
    
    @IBOutlet private var title: UILabel!
    @IBOutlet private var button: UIButton!
    var model: DetailsHeaderModel?
    
    func setup(with model: DetailsHeaderModel) {
        self.model = model
        self.title.text = model.title
        self.button.isSelected = model.showing
    }
    
    @IBAction func toogle() {
        self.model?.action()
    }
}
