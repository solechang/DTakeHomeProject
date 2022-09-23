//
//  ComicDetailsViewModel.swift
//  DisneyTakeHomeProject
//
//  Created by Chang Woo Choi on 9/22/22.
//

import Foundation
import Combine
import UIKit
final class ComicDetailsViewModel {
    
    private let networkingManager: NetworkingManagerImpl!
    private(set) var comicSubject = PassthroughSubject<Comic, Error>()
    private lazy var imageLoader = ImageLoaderManager()

    private var comicId: Int
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager(),
         comicId: Int
    ) {
        self.networkingManager = networkingManager
        self.comicId = comicId
    }
    
    func fetchComic() {
        let url = "\(NetworkingManager.comics)/\(comicId)"
        networkingManager.request(url) { result in
            switch result {
            case .success(let data):
                if let comic = data.data.results.first {
                    self.comicSubject.send(comic)
                }
            case .failure(let error):
                self.comicSubject.send(completion: .failure(error))
            }
        }
    }
    
    func downloadImage(from link: String,
                    completion: @escaping (UIImage?) -> ()) {
        imageLoader.downloadImage(from: link) { result in
            switch result {

            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case .failure:
                completion(Symbols.defaultImage)
                
            }
        }
    }
}
