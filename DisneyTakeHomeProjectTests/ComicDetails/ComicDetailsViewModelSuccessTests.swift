//
//  ComicDetailsViewModelSuccessTests.swift
//  DisneyTakeHomeProjectTests
//
//  Created by Chang Woo Choi on 9/22/22.
//

import XCTest
import Combine
@testable import DisneyTakeHomeProject

class ComicDetailsViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: ComicDetailsViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        networkingMock = NetworkingManagerComicSuccessMock()
        vm = ComicDetailsViewModel(networkingManager: networkingMock, comicId: 1308)
    }
    override func tearDown() {
        networkingMock = nil
        vm = nil
        subscriptions = []
    }
    
    func test_success_response_fetchComic() {

        let promise = expectation(description: "Should receive a comic set within NetworkingManagerComicSuccessMock")
        vm.comicSubject
            .receive(on: DispatchQueue.main)
            .sink { _ in
                XCTFail("Something went wrong.")
            } receiveValue: { comic in
                XCTAssertEqual( comic,
                                Comic(id: 50,
                                title: "Jubilee (2004) #3",
                                description: "Payton-Noble High's newest and spunkiest recruit, Jubilee, finds herself caught between her classmates and an L.A. gang rivalry. Can everyone's favorite mutant mallrat handle it in the barrio, or will Jubilee fall prey to South Central's own special blend of hospitality? And what the heck is Aunt Hope doing with all those firearms?",
                                images: [Image(
                                    path: "http://i.annihil.us/u/prod/marvel/i/mg/9/80/6050d94eb37ee",
                                    extension: "jpg"
                                        )]
                                ),
                                "Should get back a comic from the mock"
                )
                promise.fulfill()
            }
            .store(in: &subscriptions)
        
        
        vm.fetchComic()
        wait(for: [promise], timeout: 1)
    }
}
