//
//  LaunchScreenViewController.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 06.11.2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    private var rickAndMortyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var loadingComponentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.image = UIImage(named: "loadingComponent")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(rickAndMortyImageView)
        view.addSubview(loadingComponentImageView)
        
        animate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraint()
    }

//MARK: - UIAnimate
    private func animate() {
        UIView.animate(withDuration: 3, animations: {
            self.loadingComponentImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        })
        
        UIView.animate(withDuration: 3, animations: {
            self.rickAndMortyImageView.alpha = 0
            self.loadingComponentImageView.alpha = 0
        }, completion: { done in
            if done {
                let mainTabBarController = MainTabBarController()
                mainTabBarController.modalPresentationStyle = .fullScreen
                self.present(mainTabBarController, animated: false)
            }
        })
    }
}

//MARK: - Constraint
extension LaunchScreenViewController {
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            rickAndMortyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rickAndMortyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            rickAndMortyImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.smallLeftMargin),
            rickAndMortyImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.smallRightMargin),
            
            loadingComponentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingComponentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
