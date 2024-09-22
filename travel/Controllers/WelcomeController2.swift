//
//  WelcomeController2.swift
//  travel
//
//  Created by Lin Jin on 9/12/24.
//

import UIKit

class WelcomeController2: UIViewController {
    
    // MARK: - Properties (view)
    
    private let popVCButton = UIButton()
    private let textField = UITextField()
    
    // MARK: - viewDidLoad and init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ViewController Two"
        view.backgroundColor = .systemBackground
        
        setupPopVCButton()
        setupTextField()
    }
    
    // MARK: - Setup Views
    
    private func setupPopVCButton() {
        popVCButton.setTitle("Pop VC", for: .normal)
        popVCButton.setTitleColor(.systemBackground, for: .normal)
        popVCButton.backgroundColor = .systemBlue
        popVCButton.layer.cornerRadius = 10
        popVCButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        
        view.addSubview(popVCButton)
        popVCButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popVCButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popVCButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupTextField() {
        textField.placeholder = "PLACEHOLDER"
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: popVCButton.topAnchor, constant: -10),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Button Helpers
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }

}
