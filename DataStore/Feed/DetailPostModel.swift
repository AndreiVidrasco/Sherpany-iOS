import Foundation

public struct DetailPostModel {
    public struct Photo {
        public let thumbnail: URL
        public let url: URL
        public let title: String
        
        init?(photo: CDPhoto) {
            guard let thumbnail = photo.thumbnailUrl.flatMap(URL.init(string:)),
                let url = photo.url.flatMap(URL.init(string:)) else {
                return nil
            }
            self.thumbnail = thumbnail
            self.url = url
            self.title = photo.title ?? ""
        }
    }
    
    public struct Album {
        public let title: String
        public let photo: [Photo]
        
        init(album: CDAlbum) {
            self.title = album.title ?? ""
            self.photo = album.photos?.sorted(by: { $0.id ?? 0 < $1.id ?? 0 }).compactMap(Photo.init) ?? []
        }
    }
    
    public let title: String
    public let body: String
    public let albums: [Album]
    
    public init(id: Int) {
        let context = Current.dataStore.newBackgroundContext()
        let post = CDPost.lookup(id, in: context)
        self.title = post.title ?? ""
        self.body = post.body ?? ""
        self.albums = post.user?.albums?.sorted(by: { $0.id ?? 0 < $1.id ?? 0 }).map(Album.init) ?? []
    }
}

