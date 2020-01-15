import UIKit

struct DetailsBuilder {
    static func create() -> DetailsController {
        let controller = DetailsController.createFromStoryboard()
        let dataProvider = DetailsDataProvider()
        controller.dataProvider = dataProvider
        dataProvider.delegate = controller
        
        return controller
    }
}
