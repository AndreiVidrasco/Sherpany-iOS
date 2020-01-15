import Foundation

struct Resource<T: Codable> {
    let url: URL
    let parse: (Data?, Error?) -> Result<T, Error>
    
    init(url: URL, parse: ((Data?, Error?) -> Result<T, Error>)? = nil) {
        self.url = url
        self.parse = parse ?? { data, error in
            do {
                if let error = error {
                    throw error
                }
                guard let data = data else {
                    throw AnyError.unknown
                }
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch {
                return .failure(error)
            }
        }
    }
    
}
