import UIKit

protocol CacheKey {
    var encodedPath: String { get }
}

extension CacheKey {
    func resolve(relativeTo url: URL) -> URL {
        return url.appendingPathComponent(encodedPath)
    }
}

extension URL: CacheKey {
    var encodedPath: String {
        absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
    }
}

protocol CacheValue {
    var dataRepresentation: Data? { get }
    static func from(data: Data) -> Self?
}

extension UIImage: CacheValue {
    var dataRepresentation: Data? {
        return pngData()
    }
    
    static func from(data: Data) -> Self? {
        return UIImage(data: data) as? Self
    }
}

struct Cache<Key: CacheKey, Value: CacheValue> {
    let name: String
    
    let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
    
    var folder: URL { libraryURL.appendingPathComponent(name) }
    
    init(name: String) {
        self.name = name
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
    }
    
    func value(at key: Key) -> Value? {
        do {
            let data = try Data(contentsOf: key.resolve(relativeTo: folder))
            return Value.from(data: data)
        } catch {
            return nil
        }
    }
    
    func save(value: Value?, at key: Key) {
        try? value?.dataRepresentation?.write(to: key.resolve(relativeTo: folder))
    }
}
