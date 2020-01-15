import Foundation

struct NetworkUser: Codable {
    struct Geo: Codable {
        let lat: String
        let lng: String
    }
    
    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Geo
    }
    
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}
