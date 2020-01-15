import UIKit

final class PostCell: UITableViewCell {
    static let identifier = "PostCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
    }
        
    func setup(with model: PostCellModel) {
        textLabel?.text = model.title
        detailTextLabel?.text = model.subtitle
        detailTextLabel?.textColor = .lightGray
    }
}
