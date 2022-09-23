//
//  NetworkingManagerComicSuccessMock.swift
//  DisneyTakeHomeProjectTests
//
//  Created by Chang Woo Choi on 9/22/22.
//

#if DEBUG
import Foundation

class NetworkingManagerComicSuccessMock: NetworkingManagerImpl {
    
    func request(_ path: String, completion: @escaping (Result<ComicsContainer, Error>) -> Void) {
        completion(.success(
            ComicsContainer(data: Comics(results: [
                Comic(id: 50,
                title: "Jubilee (2004) #3",
                description: "Payton-Noble High's newest and spunkiest recruit, Jubilee, finds herself caught between her classmates and an L.A. gang rivalry. Can everyone's favorite mutant mallrat handle it in the barrio, or will Jubilee fall prey to South Central's own special blend of hospitality? And what the heck is Aunt Hope doing with all those firearms?",
                images: [Image(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/9/80/6050d94eb37ee",
                    extension: "jpg"
                        )]
                )]
                                        ) )
        ) )
    }
}
#endif
