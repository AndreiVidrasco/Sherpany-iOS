import Foundation

final class Webservice {
    var session = URLSession.shared
    
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A, Error>) -> ()) {
        session.dataTask(with: resource.url) { data, _, error in
            let result = resource.parse(data, error)
            completion(result)
        }.resume()
    }
}
