//
//  MainViewController.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 06.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var searchBar = UISearchBar()
    
    private var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let urls = "https://rickandmortyapi.com/api/episode"
    private var stratumCharacter: [CharacterModel] = []
    
    private var arrayCharacter = [String]()
    private var arrayEpisodeName = [String]()
    private var arrayEpisodeSpecies = [String]()
    private var arrayGender = [String]()
    private var arrayStatus = [String]()
    private var arrayOrigin = [String]()
    private var arrayType = [String]()
    private var arrayLocation = [String]()
    
    private var onLoadCharacters: (([CharacterModel]) -> ())?
    private var onLoadEpisode: ((Episode) -> ())?
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialBlue
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.cornerRadius = 10
        button.setTitle("ADVANCED FILTERS", for: .normal)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        button.imageView?.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 15).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0.0).isActive = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rickAndMortyLogoImageView: UIImageView = {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupData()
        setupSearchBar()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        setupConstraint()
    }

//MARK: - Views
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(filterButton)
        view.addSubview(collectionView)
        view.addSubview(rickAndMortyLogoImageView)
        view.addSubview(searchBar)
    }

//MARK: - Get request
    private func getDataCharacters(url: String) {
        ApiManager.path(for: Character.self, url: url) { result in
            switch result {
            case .success(let data):
                print(data)
                self.onLoadCharacters?(data.results)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getDataEpisode(url: String) {
        ApiManager.path(for: Episode.self, url: url) { result in
            switch result {
            case .success(let data):
                print(data)
                self.onLoadEpisode?(data)
            case .failure(let error):
                print(error) 
            }
        }
    }
    
//MARK: - Data
    func setupData() {
        getDataCharacters(url: urls)
        
        onLoadCharacters = { [weak self] result in
            guard let self = self else { return }
            stratumCharacter = result
            
            for i in 0...stratumCharacter.count - 1 {
                getDataEpisode(url: stratumCharacter[i].characters.randomElement() ?? "")
                
                onLoadEpisode = { [weak self] result in
                    guard let self = self else { return }
                    arrayCharacter.append(result.image)
                    arrayEpisodeName.append(result.name)
                    arrayEpisodeSpecies.append(result.species)
                    arrayOrigin.append(result.origin.name)
                    arrayGender.append(result.gender)
                    arrayStatus.append(result.status)
                    arrayType.append(result.type)
                    arrayLocation.append(result.location.name)
                    
                    if i == stratumCharacter.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }

//MARK: - CollectionView
    private func setupCollectionView() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

//MARK: - SearchBar
    private func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Name or episode (ex: S01E01)..."
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 10
        searchBar.searchTextField.backgroundColor = .clear
    }
}

//MARK: - DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stratumCharacter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.configurationCell(character: stratumCharacter[indexPath.item], image: arrayCharacter[indexPath.item], name: arrayEpisodeName[indexPath.item], species: arrayEpisodeSpecies[indexPath.item], origin: arrayOrigin[indexPath.item], gender: arrayGender[indexPath.item], status: arrayStatus[indexPath.item], type: arrayType[indexPath.item], location: arrayLocation[indexPath.item])
        
        cell.delegate = self
        return cell
    }
}

//MARK: - DelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 311, height: 357)
    }
}

//MARK: - CustomCellDelegate
extension MainViewController: CustomCellDelegate {
    func sharePressed(image: String, namePerson: String, gender: String, status: String, species: String, origin: String, type: String, location: String) {
        let characterDetailsViewController = CharacterDetailsViewController(imagePersonage: image, namePersonage: namePerson, genderPersonage: gender, statusPersonage: status, speciesPersonage: species, originPersonage: origin, typePersonage: type, locationPersonage: location)
        
        navigationController?.pushViewController(characterDetailsViewController, animated: true)
    }
}

//MARK: - Constraint
extension MainViewController {
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            rickAndMortyLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rickAndMortyLogoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.rickAndMortyLogoImageViewTop),
            rickAndMortyLogoImageView.widthAnchor.constraint(equalToConstant: Constants.rickAndMortyLogoImageViewWidth),
            rickAndMortyLogoImageView.heightAnchor.constraint(equalToConstant: Constants.rickAndMortyLogoImageViewHeight),
            
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: rickAndMortyLogoImageView.bottomAnchor, constant: Constants.searchBarTop),
            searchBar.widthAnchor.constraint(equalToConstant: Constants.searchBarWidth),
            searchBar.heightAnchor.constraint(equalToConstant: Constants.searchBarHeight),
            
            filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Constants.filterButtonTop),
            filterButton.widthAnchor.constraint(equalToConstant: Constants.filterButtonWidth),
            filterButton.heightAnchor.constraint(equalToConstant: Constants.filterButtonHeight),
            
            collectionView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: Constants.collectionViewTop),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.collectionViewBottom)
        ])
    }
}

