import DataStore
import UIKit

struct ImageDataProvider {
    static func load(url: URL, completion: @escaping (UIImage, URL) -> Void) {
        ImageDownload.shared.requestImage(url: url, completion: completion)
    }
}
