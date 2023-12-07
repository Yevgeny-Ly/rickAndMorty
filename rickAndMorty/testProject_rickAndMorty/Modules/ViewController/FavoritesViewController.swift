//
//  FavoritesViewController.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 06.11.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    private let favouritesEpisodesLabel: UILabel = {
        let label = UILabel()
        label.text = "Favourites episodes"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

//MARK: - Views
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(favouritesEpisodesLabel)
        view.addSubview(collectionView)
        
        setupConstraint()
        setupCollectionView()
    }

//MARK: - CollectionView
    private func setupCollectionView() {
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Constraint
extension FavoritesViewController {
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            favouritesEpisodesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favouritesEpisodesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            favouritesEpisodesLabel.widthAnchor.constraint(equalToConstant: 228),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85)
        ])
    }
}

//MARK: - CollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}

//MARK: - CollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    
}

//MARK: - DelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 312, height: 357)
    }
}
