import Foundation

final class Post: NSObject, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String?
    
    required init?(json: JSON) {
        guard let userId: Int = "userId" <~~ json,
                      id: Int = "id" <~~ json,
                   title: String = "title" <~~ json
            else {
                self.userId = 0
                self.id = 0
                self.title = ""
                self.body = nil
                super.init()
                return nil
        }
        self.userId = userId
        self.id = id
        self.title = title
        self.body = "body" <~~ json
        super.init()
    }
}

final class Posts: NSObject, Decodable {
    let posts: [Post]
    required init?(json: JSON) {
        guard let posts = Post.modelsFromJSONArray([json]) else {
            self.posts = []
            super.init()
            return nil
        }
        self.posts = posts
        super.init()
    }
    
    init?(jsonArray: [JSON]) {
        guard let posts = Post.modelsFromJSONArray(jsonArray) else {
            self.posts = []
            super.init()
            return nil
        }
        self.posts = posts
        super.init()
    }
}
