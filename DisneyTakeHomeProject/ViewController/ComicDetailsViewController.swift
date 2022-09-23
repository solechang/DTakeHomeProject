//
//  ComicDetailsViewController.swift
//  DisneyTakeHomeProject
//
//  Created by Chang Woo Choi on 9/21/22.
//

import Foundation
import UIKit
import Combine

final class ComicDetailsViewController: UIViewController{
    
    var comic: Comic?
    private var vm: ComicDetailsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var containerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.accessibilityIdentifier = "comicDetailsStackView"
        return sv
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        let scaledSize = UIFontMetrics(forTextStyle: .body).scaledValue(for: 24)
        label.font = .systemFont(ofSize: scaledSize, weight: .bold)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        let scaledSize = UIFontMetrics(forTextStyle: .body).scaledValue(for: 16)
        label.font = .systemFont(ofSize: scaledSize, weight: .regular)
        return label
    }()
    
    init(_ comic: Comic) {
        self.comic = comic
        
        #if DEBUG
        if UITestingHelper.isUITesting {
            // Depending on what we set in UITestingHelper, we can choose which mocks to test for UI Testing
            let mock = NetworkingManagerComicSuccessMock()
            self.vm = ComicDetailsViewModel(networkingManager: mock, comicId: comic.id)
        } else {
            self.vm = ComicDetailsViewModel(comicId: comic.id )
        }
        #else
            self.vm = ComicDetailsViewModel(comicId: comic.id ?? 0)
        #endif
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubscription()
        vm.fetchComic()
    }
}
private extension ComicDetailsViewController {
    func setup() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(imageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
           
            imageView.heightAnchor.constraint(equalToConstant: 250)
        
        ])
    }
    
    func setupSubscription() {
        vm.comicSubject
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error)
                    if error is NetworkingManager.NetworkingError {
                        self.showFailed(message: "Something went wrong!")
                    }
                case .finished:
                    break
                }
            } receiveValue: { data in
                self.titleLabel.text = data.title
                
                if data.description == "" {
                    self.descriptionLabel.text = "No description"
                } else {
                    self.descriptionLabel.text = data.description
                }
                
                let imageURL = "\(data.images?.first?.path ?? "").\(data.images?.first?.extension ?? "")"
                self.vm.downloadImage(from: imageURL, completion: { image in
                    DispatchQueue.main.async { [weak self] in
                        self?.imageView.image = image
                    }
                })

            }
            .store(in: &subscriptions)
    }
}
