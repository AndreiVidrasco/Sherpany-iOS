// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import CoreData
import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable attributes file_length vertical_whitespace_closing_braces
// swiftlint:disable identifier_name line_length type_body_length

// MARK: - CDAddress

final class CDAddress: NSManagedObject {
  class func entityName() -> String {
    return "CDAddress"
  }

  class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName(), in: managedObjectContext)
  }

  @nonobjc class func fetchRequest() -> NSFetchRequest<CDAddress> {
    return NSFetchRequest<CDAddress>(entityName: entityName())
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
  @NSManaged var city: String?
  @NSManaged var street: String?
  @NSManaged var suite: String?
  @NSManaged var zipcode: String?
  @NSManaged var geo: CDGeo?
  @NSManaged var user: CDUser?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: - CDAlbum

final class CDAlbum: NSManagedObject {
  class func entityName() -> String {
    return "CDAlbum"
  }

  class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName(), in: managedObjectContext)
  }

  @nonobjc class func fetchRequest() -> NSFetchRequest<CDAlbum> {
    return NSFetchRequest<CDAlbum>(entityName: entityName())
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
  var id: Int64? {
    get {
      let key = "id"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Int64
    }
    set {
      let key = "id"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue, forKey: key)
    }
  }
  @NSManaged var title: String?
  @NSManaged var photos: Set<CDPhoto>?
  @NSManaged var user: CDUser?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: Relationship Photos

extension CDAlbum {
  @objc(addPhotosObject:)
  @NSManaged func addToPhotos(_ value: CDPhoto)

  @objc(removePhotosObject:)
  @NSManaged func removeFromPhotos(_ value: CDPhoto)

  @objc(addPhotos:)
  @NSManaged func addToPhotos(_ values: Set<CDPhoto>)

  @objc(removePhotos:)
  @NSManaged func removeFromPhotos(_ values: Set<CDPhoto>)
}

// MARK: - CDCompany

final class CDCompany: NSManagedObject {
  class func entityName() -> String {
    return "CDCompany"
  }

  class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName(), in: managedObjectContext)
  }

  @nonobjc class func fetchRequest() -> NSFetchRequest<CDCompany> {
    return NSFetchRequest<CDCompany>(entityName: entityName())
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
  @NSManaged var bs: String?
  @NSManaged var catchPhrase: String?
  @NSManaged var name: String?
  @NSManaged var user: CDUser?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: - CDGeo

final class CDGeo: NSManagedObject {
  class func entityName() -> String {
    return "CDGeo"
  }

  class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName(), in: managedObjectContext)
  }

  @nonobjc class func fetchRequest() -> NSFetchRequest<CDGeo> {
    return NSFetchRequest<CDGeo>(entityName: entityName())
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
  @NSManaged var lat: String?
  @NSManaged var long: String?
  @NSManaged var address: CDAddress?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: - CDPhoto

final class CDPhoto: NSManagedObject {
  class func entityName() -> String {
    return "CDPhoto"
  }

  class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName(), in: managedObjectContext)
  }

  @nonobjc class func fetchRequest() -> NSFetchRequest<CDPhoto> {
    return NSFetchRequest<CDPhoto>(entityName: entityName())
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
  var id: Int64? {
    get {
      let key = "id"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Int64
    }
    set {
      let key = "id"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue, forKey: key)
    }
  }
  @NSManaged var thumbnailUrl: String?
  @NSManaged var title: String?
  @NSManaged var url: String?
  @NSManaged var album: CDAlbum?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: - CDPost

final class CDPost: NSManagedObject {
  class func entityName() -> String {
    return "CDPost"
  }

  class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName(), in: managedObjectContext)
  }

  @nonobjc class func fetchRequest() -> NSFetchRequest<CDPost> {
    return NSFetchRequest<CDPost>(entityName: entityName())
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
  @NSManaged var body: String?
  var id: Int64? {
    get {
      let key = "id"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Int64
    }
    set {
      let key = "id"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue, forKey: key)
    }
  }
  @NSManaged var title: String?
  @NSManaged var user: CDUser?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: - CDUser

final class CDUser: NSManagedObject {
  class func entityName() -> String {
    return "CDUser"
  }

  class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName(), in: managedObjectContext)
  }

  @nonobjc class func fetchRequest() -> NSFetchRequest<CDUser> {
    return NSFetchRequest<CDUser>(entityName: entityName())
  }

  // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
  @NSManaged var email: String?
  var id: Int64? {
    get {
      let key = "id"
      willAccessValue(forKey: key)
      defer { didAccessValue(forKey: key) }

      return primitiveValue(forKey: key) as? Int64
    }
    set {
      let key = "id"
      willChangeValue(forKey: key)
      defer { didChangeValue(forKey: key) }

      setPrimitiveValue(newValue, forKey: key)
    }
  }
  @NSManaged var name: String?
  @NSManaged var phone: String?
  @NSManaged var username: String?
  @NSManaged var website: String?
  @NSManaged var address: CDAddress?
  @NSManaged var albums: Set<CDAlbum>?
  @NSManaged var company: CDCompany?
  @NSManaged var posts: Set<CDPost>?
  // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: Relationship Albums

extension CDUser {
  @objc(addAlbumsObject:)
  @NSManaged func addToAlbums(_ value: CDAlbum)

  @objc(removeAlbumsObject:)
  @NSManaged func removeFromAlbums(_ value: CDAlbum)

  @objc(addAlbums:)
  @NSManaged func addToAlbums(_ values: Set<CDAlbum>)

  @objc(removeAlbums:)
  @NSManaged func removeFromAlbums(_ values: Set<CDAlbum>)
}

// MARK: Relationship Posts

extension CDUser {
  @objc(addPostsObject:)
  @NSManaged func addToPosts(_ value: CDPost)

  @objc(removePostsObject:)
  @NSManaged func removeFromPosts(_ value: CDPost)

  @objc(addPosts:)
  @NSManaged func addToPosts(_ values: Set<CDPost>)

  @objc(removePosts:)
  @NSManaged func removeFromPosts(_ values: Set<CDPost>)
}

// swiftlint:enable identifier_name line_length type_body_length
