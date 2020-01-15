import UIKit

final class SplitViewController: UISplitViewController, FeedControllerDelegate, UISplitViewControllerDelegate {
    
    func imageDownloaded(day: String) {}
    
    
    private weak var forecastController: FeedController?
    private weak var detailsController: DetailsController?
    
     init() {
        super.init(nibName: nil, bundle: nil)

        setupControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    // MARK: - ForecastControllerDelegate
    
    func postSelected(post: PostId) {
        guard let detailsController = detailsController else { return }
        if isCollapsed { showDetailViewController(UINavigationController(rootViewController: detailsController), sender: self) }
        detailsController.setup(model: post)
    }
    
    // MARK: - Private funcations
    
    private func setupControllers() {
        let forecastController = FeedBuilder.create()
        let detailsController = DetailsBuilder.create()
        self.forecastController = forecastController
        self.detailsController = detailsController
        self.forecastController?.delegate = self
        viewControllers = [UINavigationController(rootViewController: forecastController),
                           UINavigationController(rootViewController: detailsController)]
        detailsController.navigationItem.leftBarButtonItem = displayModeButtonItem
        detailsController.navigationItem.leftItemsSupplementBackButton = true
        delegate = self
        preferredDisplayMode = .allVisible
    }
}
