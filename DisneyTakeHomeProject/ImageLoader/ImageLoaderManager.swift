//
//  ImageLoaderManager.swift
//  DisneyTakeHomeProject
//
//  Created by Chang Woo Choi on 9/23/22.
//

import Foundation


class ImageLoaderManager {
    func downloadImage(from link: String,
                       completion: @escaping (Result<(Data),Error>) -> ()) {
        guard let url = URL(string: link) else {
            completion(.failure(ImageLoadingError.custom(error: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let mimeType = response?.mimeType,                    mimeType.hasPrefix("image"),
                let data = data, error == nil else {
                completion(.failure(ImageLoadingError.custom(error: nil)))
                    return
                }
            
            completion(.success(data))
        }.resume()
    }
}

extension ImageLoaderManager {
    enum ImageLoadingError: LocalizedError {
        case custom(error: Error?)
    }
}

extension ImageLoaderManager.ImageLoadingError {
    var errorDescription: String?{
        switch self {
        case .custom(let err):
            return "Something went wrong. \(err?.localizedDescription ?? "")"
        }
    }
}
