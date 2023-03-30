//
//  DetailViewController.swift
//  GiphyApp
//
//  Created by Fed on 28.03.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var gif: GIF
    
    // MARK: - Init & ViewDidLoad
    
    init(_ gif: GIF) {
        self.gif = gif
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavController()
    }
    
    // MARK: - UI Elements
    
    private lazy var detailView = DetailView(gif: gif)
}

// MARK: - Private Methods

private
extension DetailViewController {
    
    func configureView() {
        view.backgroundColor = Media.Color.backPrimary.color
    }
    
    func configureNavController() {
        let backButton = UIBarButtonItem(systemItem: .close, primaryAction: UIAction(handler: { _ in
            self.dismiss(animated: true)
        }))
        navigationItem.leftBarButtonItem = backButton
    }
}
