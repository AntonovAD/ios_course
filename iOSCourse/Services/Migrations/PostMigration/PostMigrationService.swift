//

import Foundation

protocol PostMigrationServiceProtocol: MigrationServiceProtocol {
    
}

class PostMigrationService: PostMigrationServiceProtocol {
    private let postProvider: PostProviderProtocol
    private let dataStorage: PostMigrationDataStorage
    
    init(
        postProvider: PostProviderProtocol,
        dataStorage: PostMigrationDataStorage
    ) {
        self.postProvider = postProvider
        self.dataStorage = dataStorage
    }
    
    func migrateIfNeeded() {
        print("PostMigrationService - migrationVersion:", dataStorage.migrationVersion)
        
        switch dataStorage.migrationVersion {
        case 0:
            preseed()
            fallthrough
            
        default:
            break
        }
    }
    
    private func preseed() {
        DispatchQueue.main.async { [postProvider, dataStorage] in
            guard let path = Bundle.main.path(forResource: "Posts", ofType: "json") else {
                return
            }
            
            let url = URL(fileURLWithPath: path)
            
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            
            let decoder = JSONDecoder()
            
            guard let posts = try? decoder.decode([Post].self, from: data) else {
                return
            }
            
            postProvider.update(posts: posts) { result in
                guard case .success = result else {
                    return
                }
                
                dataStorage.migrationVersion = 1
            }
        }
    }
}
