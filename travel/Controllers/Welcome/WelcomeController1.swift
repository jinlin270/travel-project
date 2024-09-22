//
//  WelcomeController1.swift
//  travel
//
//  Created by Lin Jin on 9/12/24.
//

import UIKit

class WelcomeController1: UIViewController {
    
    // MARK: - Properties (view)
    private let appLabel = UILabel()
    private let carImageView = UIImageView()
    private let lineView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the style for the label
        setupLineView()
        setupcarImageView()
        view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    private let pushVCButton = UIButton()
    private let textLabel = UILabel()
    
    // MARK: - Properties (data)
    
    private func setupcarImageView() {
            carImageView.translatesAutoresizingMaskIntoConstraints = false
            carImageView.image = UIImage(named: "car")
            
            view.addSubview(carImageView)
            carImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                carImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 472),
                carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        }
    
    private func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the background color to match the RGB values.
        lineView.backgroundColor = .black
        
        // Add the view to the parent view.
        view.addSubview(lineView)
        view.sendSubviewToBack(lineView)
        
        // Set the constraints for the width and height.
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalToConstant: 393),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 541)
        ])
    }
   
    // MARK: - Change Views
    
    @objc private func viewTapped() {
        let welcomeController2 = WelcomeController2()
        navigationController?.pushViewController(welcomeController2, animated: true)
    }
}
