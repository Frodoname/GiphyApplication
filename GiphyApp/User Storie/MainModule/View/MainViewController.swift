//
//  MainViewController.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    typealias DataSource =  UICollectionViewDiffableDataSource<Section, GIF>
    
    // MARK: - Constants
    
    private let viewModel: MainViewModel
    private let searchController = UISearchController()
    private var collectionView: UICollectionView!
    private var dataSource: DataSource?
    private var bindingSet = Set<AnyCancellable>()
    
    // MARK: - Init & ViewDidLoad

    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        configureSearchBarListener()
        configureViewModelListeners()
        viewModel.getData()
        viewModel.playSound()
    }
}

// MARK: - Configure Methods

private
extension MainViewController {
    
    func configureView() {
        view.backgroundColor = Media.Color.backPrimary.color
    }
    
    func configureNavBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Text.mainTitle
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Text.search
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = Media.Color.labelPrimary.color
    }
    
    func configureSearchBarListener() {
        searchController.searchBar.searchTextField
            .textPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] query in
                guard let self else { return }
                self.viewModel.canLoadMoreItems = true
                self.viewModel.currentOffset = 0
                self.viewModel.currentSearchQuery = query
                self.viewModel.isFirstPageLoading = true
                self.viewModel.getData()
            }
            .store(in: &bindingSet)
    }
    
    func configureViewModelListeners() {
        viewModel.$gifs
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self else { return }
                self.createSnapshot()
            })
            .store(in: &bindingSet)
        
        let stateValueHandler: (ViewModelState) -> Void = { [weak self] state in
            guard let self else { return }
            
            switch state {
            case .initialLoading:
                self.collectionView.setAnimation()
            case .loading:
                break
            case .noResult:
                self.collectionView.showError(.noResults)
            case .successfulLoaded:
                self.collectionView.restore()
                self.createSnapshot()
            case .error:
                self.collectionView.showError(.dataError) {
                    self.viewModel.getData()
                }
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindingSet)
    }
}

// MARK: - CollectionView Configuration

private
extension MainViewController {
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.register(GiphyCell.self, forCellWithReuseIdentifier: GiphyCell.identifier)
        collectionView.backgroundColor = Media.Color.backPrimary.color
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        dataSource =
        UICollectionViewDiffableDataSource<Section, GIF>(collectionView: collectionView,
                                                         cellProvider: { _, indexPath, model in
            self.configure(GiphyCell.self, with: model, for: indexPath)
        })
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

// MARK: - CollectionView Delegate

extension MainViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let collectionViewContentSizeHeight = collectionView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > (collectionViewContentSizeHeight - 100 - scrollViewHeight) {
            viewModel.getData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentGif = viewModel.gifs[indexPath.row]
        let detailVC = DetailViewController(currentGif)
        let navigationVC = UINavigationController(rootViewController: detailVC)
        present(navigationVC, animated: true)
    }
}

// MARK: - SearchBar Delegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.currentSearchQuery = nil
        viewModel.canLoadMoreItems = true
        viewModel.currentOffset = 0
        viewModel.getData()
    }
}

private
extension MainViewController {
    
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, GIF>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.gifs)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func configure<T: ReusableCellProtocol>(_ cellType: T.Type, with model: GIF, for indexPath: IndexPath) -> T {
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: GiphyCell.identifier,
                for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: model)
        return cell
    }
}
