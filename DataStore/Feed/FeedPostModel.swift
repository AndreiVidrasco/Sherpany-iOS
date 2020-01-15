import Foundation

public struct FeedPostModel: Equatable {
    public let id: Int
    public let text: String
    public let email: String
    
    init(post: CDPost) {
        self.id = post.id.map(Int.init) ?? 0
        self.text = post.title ?? ""
        self.email = post.user?.email ?? ""
    }
    
    public func delete() {
        let context = Current.dataStore.newBackgroundContext()
        let post = CDPost.lookup(id, in: context)
        context.delete(post)
        do {
            try context.save()
        } catch {
            print(error)
            //Handle error
        }
    }
}
