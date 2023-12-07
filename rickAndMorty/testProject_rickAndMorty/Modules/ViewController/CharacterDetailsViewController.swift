//
//  CharacterDetailsViewController.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 10.11.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    private let tableView = UITableView()
    
    var imagePerson = String()
    var namePerson = String()
    var genderPerson = String()
    var statusPerson = String()
    var speciesPerson = String()
    var originPerson = String()
    var typePerson = String()
    var locationPerson = String()
    
    init(imagePersonage: String, namePersonage: String, genderPersonage: String, statusPersonage: String, speciesPersonage: String, originPersonage: String, typePersonage: String, locationPersonage: String) {
        super.init(nibName: nil, bundle: nil)
        imagePerson = imagePersonage
        namePerson = namePersonage
        genderPerson = genderPersonage
        statusPerson = statusPersonage
        speciesPerson = speciesPersonage
        originPerson = originPersonage
        typePerson = typePersonage
        locationPerson = locationPersonage
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellTitle = ["Gender", "Status", "Species", "Origin", "Type", "Location"]
    
    lazy var indexPathCell = [genderPerson, statusPerson, speciesPerson, originPerson, typePerson, locationPerson]
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 147).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 148).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var photoChangerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapPhotoChangerButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let namePersonageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 36)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoPersonageLabel: UILabel = {
        let label = UILabel()
        label.text = "Informations"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 16.0, *) {
            setupViews()
        } else {
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
    }

//MARK: - Views
    @available(iOS 16.0, *)
    private func setupViews() {
        namePersonageLabel.text = namePerson
        
        view.backgroundColor = .white
        
        view.addSubview(userImageView)
        view.addSubview(photoChangerButton)
        view.addSubview(namePersonageLabel)
        view.addSubview(infoPersonageLabel)
        view.addSubview(tableView)
        
        setupBarButtonItem()
        setupConstraint()
        setupTableView()
        characterImageData()
    }

//MARK: - Data
    private func characterImageData() {
        guard let url = URL(string: imagePerson) else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.userImageView.image = UIImage(data: data ?? Data())
            }
        }
    }

//MARK: - BarButtonItem
    @available(iOS 16.0, *)
    private func setupBarButtonItem() {
        let rickAndMortySiluetItem = UIBarButtonItem(title: "", image: UIImage(named: "rickAndMortySiluet"), target: self, action: nil)
        navigationItem.rightBarButtonItem = rickAndMortySiluetItem
        
        let backButton = UIBarButtonItem()
        backButton.title = "Go Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let backImage = UIImage(systemName: "arrow.left")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.tintColor = .black
    }

//MARK: - setupTableView
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.reuseIdentifier)
        tableView.dataSource = self
    }

//MARK: - @objc func
    @objc
    private func tapPhotoChangerButton() {
        print("tap Photo Changer Button")
    }
}

//MARK: - Constraint
extension CharacterDetailsViewController {
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            
            photoChangerButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            photoChangerButton.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 15),
            photoChangerButton.widthAnchor.constraint(equalToConstant: 32),
            photoChangerButton.heightAnchor.constraint(equalToConstant: 32),
            
            namePersonageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            namePersonageLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 15),
            
            infoPersonageLabel.topAnchor.constraint(equalTo: namePersonageLabel.bottomAnchor, constant: 15),
            infoPersonageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            
            tableView.topAnchor.constraint(equalTo: infoPersonageLabel.bottomAnchor, constant: 15),
            tableView.widthAnchor.constraint(equalToConstant: 312),
            tableView.heightAnchor.constraint(equalToConstant: 424),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//MARK: - TableViewDataSource
extension CharacterDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.reuseIdentifier, for: indexPath) as? DetailsTableViewCell else { return UITableViewCell() }
        let headerTitle = cellTitle[indexPath.row]
        let subheadingTitle = indexPathCell[indexPath.row]
        
        cell.configureCell(header: headerTitle, subHeader: subheadingTitle)
        
        return cell
    }
}
