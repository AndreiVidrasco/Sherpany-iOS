import UIKit

struct FeedBuilder {
    static func create() -> FeedController {
        let controller = FeedController.createFromStoryboard()
        let dataProvider = FeedDataProvider()
        controller.dataProvider = dataProvider
        dataProvider.delegate = controller
        
        return controller
    }
}

