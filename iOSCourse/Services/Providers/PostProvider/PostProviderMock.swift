//

import Foundation
import ReactiveSwift

class PostProviderMock: PostProviderProtocol, ReactivePostProviderProtocol {
    private let mutablePosts = MutableProperty<[Post]>([])
    let posts: Property<[Post]>
    
    init() {
        posts = Property(mutablePosts)
        mutablePosts <~ requestAll().flatMapError { _ in .init(value: []) }
    }
    
    // MARK: 🐌 Not Reactive
    func requestAll(completion: @escaping (Result<[Post], PostProviderError>) -> Void) {
        DispatchQueue.main.async {
            let data = postsMockJson.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            let posts = try! jsonDecoder.decode([Post].self, from: data)
            
            completion(.success((posts)))
        }
    }
    
    func update(post: Post, completion: @escaping (Result<(), PostProviderError>) -> Void) {
        DispatchQueue.main.async {
            completion(.success(()))
        }
    }
    
    func update(posts: [Post], completion: @escaping (Result<(), PostProviderError>) -> Void) {
        DispatchQueue.main.async {
            completion(.success(()))
        }
    }
    
    // MARK: 🚀 Reactive
    func requestAll() -> SignalProducer<[Post], PostProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.requestAll { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func update(post: Post) -> SignalProducer<(), PostProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.update(post: post) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func update(posts: [Post]) -> SignalProducer<(), PostProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.update(posts: posts) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
}

private let postsMockJson = """
[
    {
      "id": 1,
      "title": "Заголовок. Длинной интересной статьи",
      "text": "Текст. Равным образом дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. Идейные соображения высшего порядка, а также сложившаяся структура организации представляет собой интересный эксперимент проверки форм развития.",
      "status_id": 1,
      "author_id": 1,
      "created_at": "2021-05-17 14:10:00",
      "updated_at": "2021-05-17 14:10:00",
      "deleted_at": null,
      "likes": 452,
      "dislikes": 8,
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
        },
        {
          "id": 3,
          "name": "tag3124125125",
          "created_at": "2021-05-17 14:10:00",
          "updated_at": "2021-05-17 14:10:00",
          "deleted_at": null,
          "pivot": {
            "post_id": 2,
            "tag_id": 2
          }
        },
        {
          "id": 4,
          "name": "tag4",
          "created_at": "2021-05-17 14:10:00",
          "updated_at": "2021-05-17 14:10:00",
          "deleted_at": null,
          "pivot": {
            "post_id": 2,
            "tag_id": 2
          }
        },
        {
          "id": 5,
          "name": "tag5",
          "created_at": "2021-05-17 14:10:00",
          "updated_at": "2021-05-17 14:10:00",
          "deleted_at": null,
          "pivot": {
            "post_id": 2,
            "tag_id": 2
          }
        },
      ],
      "comments": [],
      "popular_comment": []
    },
  {
    "id": 2,
    "title": "PostProviderMock",
    "text": "PostProviderMock PostProviderMock PostProviderMock PostProviderMock PostProviderMock PostProviderMock PostProviderMock PostProviderMock",
    "status_id": 1,
    "author_id": 1,
    "created_at": "2021-05-17 14:10:00",
    "updated_at": "2021-05-17 14:10:00",
    "deleted_at": null,
    "likes": 4972,
    "dislikes": 34,
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
      },
      {
        "id": 3,
        "name": "tag3124125125",
        "created_at": "2021-05-17 14:10:00",
        "updated_at": "2021-05-17 14:10:00",
        "deleted_at": null,
        "pivot": {
          "post_id": 2,
          "tag_id": 2
        }
      },
      {
        "id": 4,
        "name": "tag4",
        "created_at": "2021-05-17 14:10:00",
        "updated_at": "2021-05-17 14:10:00",
        "deleted_at": null,
        "pivot": {
          "post_id": 2,
          "tag_id": 2
        }
      },
      {
        "id": 5,
        "name": "tag5",
        "created_at": "2021-05-17 14:10:00",
        "updated_at": "2021-05-17 14:10:00",
        "deleted_at": null,
        "pivot": {
          "post_id": 2,
          "tag_id": 2
        }
      },
    ],
    "comments": [],
    "popular_comment": []
  },
  {
    "id": 3,
    "title": "PostProviderMock",
    "text": "PostProviderMock",
    "status_id": 1,
    "author_id": 1,
    "created_at": "2020-10-01 16:21:47",
    "updated_at": "2020-10-01 16:21:47",
    "deleted_at": null,
    "likes": 11,
    "dislikes": 88,
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
