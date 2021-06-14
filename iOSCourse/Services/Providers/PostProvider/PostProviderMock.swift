//

import Foundation

class PostProviderMock: PostProviderProtocol {
    func requestAll(completion: @escaping (Result<[Post], PostProviderError>) -> Void) {
        DispatchQueue.main.async {
            let data = postsMockJson.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            let posts = try! jsonDecoder.decode([Post].self, from: data)
            
            completion(.success((posts)))
        }
    }
}

private let postsMockJson = """
[
  {
    "id": 2,
    "title": "теговый черновик",
    "text": "jhgj kjh kjh jkxchk hcxkjh kxch kxchk xckj chx cjkx xck",
    "status_id": 1,
    "author_id": 1,
    "created_at": "2021-05-17 14:10:00",
    "updated_at": "2021-05-17 14:10:00",
    "deleted_at": null,
    "likes": 0,
    "dislikes": 0,
    "status": {
      "id": 1,
      "name": "Опубликован",
      "created_at": "2020-10-01 16:21:35",
      "updated_at": null,
      "deleted_at": null
    },
    "author": {
      "id": 1,
      "lname": "Антонов",
      "fname": "Андрей",
      "user_id": 1,
      "created_at": "2020-10-01 16:21:35",
      "updated_at": null,
      "deleted_at": null
    },
    "tags": [
      {
        "id": 1,
        "name": "tag1",
        "created_at": "2021-05-17 14:10:00",
        "updated_at": "2021-05-17 14:10:00",
        "deleted_at": null,
        "pivot": {
          "post_id": 2,
          "tag_id": 1
        }
      },
      {
        "id": 2,
        "name": "tag2",
        "created_at": "2021-05-17 14:10:00",
        "updated_at": "2021-05-17 14:10:00",
        "deleted_at": null,
        "pivot": {
          "post_id": 2,
          "tag_id": 2
        }
      }
    ],
    "comments": [],
    "popular_comment": []
  },
  {
    "id": 1,
    "title": "mysql",
    "text": "top",
    "status_id": 1,
    "author_id": 1,
    "created_at": "2020-10-01 16:21:47",
    "updated_at": "2020-10-01 16:21:47",
    "deleted_at": null,
    "likes": 1,
    "dislikes": 0,
    "status": {
      "id": 1,
      "name": "Опубликован",
      "created_at": "2020-10-01 16:21:35",
      "updated_at": null,
      "deleted_at": null
    },
    "author": {
      "id": 1,
      "lname": "Антонов",
      "fname": "Андрей",
      "user_id": 1,
      "created_at": "2020-10-01 16:21:35",
      "updated_at": null,
      "deleted_at": null
    },
    "tags": [],
    "comments": [],
    "popular_comment": []
  }
]
"""
