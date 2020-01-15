import UIKit
import Foundation

public class ImageDownload {
    private let cache = Cache<URL, UIImage>(name: "Images")
    private let session = URLSession.shared
    public static var shared = ImageDownload()
    
    public func requestImage(url: URL, completion: @escaping (UIImage, URL) -> Void) {
        if let image = cache.value(at: url) {
            return completion(image, url)
        }
        session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            if error != nil {
                // Handle error
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                // Handle wrong/bad data
                return
            }
            self?.cache.save(value: image, at: url)
            DispatchQueue.main.async {
                completion(image, url)
            }
        }).resume()
    }
}

