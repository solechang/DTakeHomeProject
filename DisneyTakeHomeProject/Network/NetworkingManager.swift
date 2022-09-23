//
//  NetworkManager.swift
//  DisneyTakeHomeProject
//
//  Created by Chang Woo Choi on 9/21/22.
//

import Foundation

protocol NetworkingManagerImpl {
    func request(_ path: String,
                 completion: @escaping (Result<ComicsContainer, Error>) -> Void)
}

final class NetworkingManager: NetworkingManagerImpl {
    
    private static let APIKey = "15c9ddd5c1a97e4141ed6d8a80985e00"
    private static let privateKey = "" // We shouldn't store privateKey. What we can do is we can pull the privateKey from our own backend server and store it in a keychain
    static let comics = "/v1/public/comics"

    func request(_ path: String,
                 completion: @escaping (Result<ComicsContainer, Error>) -> Void) {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.path = path
        
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(NetworkingManager.privateKey)\(NetworkingManager.APIKey)".MD5()

        var requestQueryItems = [URLQueryItem]()

        requestQueryItems.append(URLQueryItem(name: "apikey", value: NetworkingManager.APIKey))
        requestQueryItems.append(URLQueryItem(name: "ts", value: ts))
        requestQueryItems.append(URLQueryItem(name: "hash", value: hash))
        
        urlComponents.queryItems = requestQueryItems
        
        guard let url = urlComponents.url else {
                return
        }
//        print(url)
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error)))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkingError.custom(error: nil)))
                return
            }
//            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
//               print(JSONString)
//            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ComicsContainer.self, from: data)
       
                completion(.success(result))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        }.resume()
    }
    
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case failedToDecode(error: Error)
        case custom(error: Error?)
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String?{
        switch self {
        case .failedToDecode(let err):
            return "Something went wrong decoding \(err.localizedDescription)"
        case .custom(let err):
            return "Something went wrong. \(err?.localizedDescription ?? "")"
        }
    }
}

