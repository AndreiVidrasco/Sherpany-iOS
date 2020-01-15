import Foundation

struct Environment {
    var urlSession = URLSession.shared
    var webservice = Webservice()
    var dataStore = DataStoreObject.shared
}

var Current = Environment()
