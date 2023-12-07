//
//  DetailsTableViewCell.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 12.11.2023.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = NSStringFromClass(DetailsTableViewCell.self)
    
    var header = String()
    var subHeader = String()
    
    private let infoHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoSubheadingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var infoStackView = UIStackView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViewsCell()
    }

//MARK: - SetupViewsCell
    private func setupViewsCell() {
        infoStackView = UIStackView(arrangedSubviews: [infoHeaderLabel, infoSubheadingLabel], axis: .vertical, spacing: 5)
        contentView.addSubview(infoStackView)
        
        setupConstraint()
    }

//MARK: - ConfigurationCell
    func configureCell(header: String, subHeader: String) {
        infoHeaderLabel.text = header
        infoSubheadingLabel.text = subHeader
    }
}

//MARK: - Constraint
extension DetailsTableViewCell {
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            infoStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
        ])
    }
}
