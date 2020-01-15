import UIKit

struct ImageViewBuilder {
    static func create(url: URL) -> UIViewController {
        let controller = ImageViewController(url: url)
        return UINavigationController(rootViewController: controller)
    }
}
