//
//  UICollectionViewCell.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 07.11.2023.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func sharePressed(image: String, namePerson: String, gender: String, status: String, species: String, origin: String, type: String, location: String)
}

class CollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CustomCellDelegate?
    
    static let reuseIdentifier = NSStringFromClass(CollectionViewCell.self)
    
    private var statusIsFavoriteButton = false
    
    var imagePersonage = String()
    var namePersonage = String()
    var genderPersonage = String()
    var statusPersonage = String()
    var speciesPersonage = String()
    var originPersonage = String()
    var typePersonage = String()
    var locationPersonage = String()
    
    private let backgtoundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var characterImageView: UIImageView = {
        let tapsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapsGestureRecognizer)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let iconReproductionsUI: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play.rectangle")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let namePersonageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speciesPersonageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameEpisode: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let numberEpisode: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(pressButtonFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var nameAndNumberEpisodeStackView = UIStackView()
    
//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Views
    private func setupViews() {
        backgroundColor = .white
        
        nameAndNumberEpisodeStackView = UIStackView(arrangedSubviews: [iconReproductionsUI, nameEpisode, lineView, numberEpisode], axis: .horizontal, spacing: 5)
        
        addSubview(backgtoundCell)
        backgtoundCell.addSubview(nameAndNumberEpisodeStackView)
        backgtoundCell.addSubview(namePersonageLabel)
        backgtoundCell.addSubview(characterImageView)
        backgtoundCell.addSubview(favoriteButton)
        backgtoundCell.addSubview(speciesPersonageLabel)
        
        setupConstraint()
    }

//MARK: - configurationCell
    func configurationCell(character: CharacterModel, image: String, name: String, species: String, origin: String, gender: String, status: String, type: String, location: String) {
        
        guard let url = URL(string: image) else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: data ?? Data())
            }
        }
        
        nameEpisode.text = character.name
        numberEpisode.text = character.episode
        namePersonageLabel.text = name
        speciesPersonageLabel.text = species
        
        imagePersonage = image
        namePersonage = name
        genderPersonage = gender
        statusPersonage = status
        speciesPersonage = species
        originPersonage = origin
        typePersonage = type
        locationPersonage = location
    }

//MARK: - @objc func
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        delegate?.sharePressed(image: imagePersonage, namePerson: namePersonage, gender: genderPersonage, status: statusPersonage, species: speciesPersonage, origin: originPersonage, type: typePersonage, location: locationPersonage)
    }

    @objc
    private func pressButtonFavorite() {
        
        let noFavoriteProductImage = UIImage(systemName: "heart")
        let favoriteProductImage = UIImage(systemName: "heart.fill")
        
        UIView.animate(withDuration: 0.1, animations: {
            if !self.statusIsFavoriteButton {
                self.favoriteButton.setImage(favoriteProductImage, for: .normal)
                self.favoriteButton.transform = (self.favoriteButton.transform.scaledBy(x: Constants.scale, y: Constants.scale))
                self.statusIsFavoriteButton = true
                self.favoriteButton.tintColor = .red
            } else {
                self.favoriteButton.setImage(noFavoriteProductImage, for: .normal)
                self.favoriteButton.transform = (self.favoriteButton.transform.scaledBy(x: Constants.scale, y: Constants.scale))
                self.statusIsFavoriteButton = false
                self.favoriteButton.tintColor = .black
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.favoriteButton.transform = CGAffineTransform.identity
            })
        })
    }
}

//MARK: - Constraint
extension CollectionViewCell {
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            backgtoundCell.topAnchor.constraint(equalTo: topAnchor, constant: 2.5),
            backgtoundCell.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            backgtoundCell.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            backgtoundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.5),
            
            characterImageView.topAnchor.constraint(equalTo: backgtoundCell.topAnchor),
            characterImageView.leftAnchor.constraint(equalTo: backgtoundCell.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: backgtoundCell.rightAnchor),
            characterImageView.heightAnchor.constraint(equalTo: backgtoundCell.heightAnchor, multiplier: 2/3),
            
            namePersonageLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 15),
            namePersonageLabel.leftAnchor.constraint(equalTo: backgtoundCell.leftAnchor, constant: 30),
            namePersonageLabel.rightAnchor.constraint(equalTo: backgtoundCell.rightAnchor, constant: -30),
            
            speciesPersonageLabel.topAnchor.constraint(equalTo: namePersonageLabel.bottomAnchor, constant: 5),
            speciesPersonageLabel.leftAnchor.constraint(equalTo: backgtoundCell.leftAnchor, constant: 30),
            
            lineView.heightAnchor.constraint(equalToConstant: 20),
            lineView.widthAnchor.constraint(equalToConstant: 2),
            
            nameAndNumberEpisodeStackView.topAnchor.constraint(equalTo: namePersonageLabel.bottomAnchor, constant: 30),
            nameAndNumberEpisodeStackView.leftAnchor.constraint(equalTo: backgtoundCell.leftAnchor, constant: 30),
            nameAndNumberEpisodeStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -90),
            
            favoriteButton.topAnchor.constraint(equalTo: namePersonageLabel.bottomAnchor, constant: 30),
            favoriteButton.rightAnchor.constraint(equalTo: backgtoundCell.rightAnchor, constant: -30),
        ])
    }
}
