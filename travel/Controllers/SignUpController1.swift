//
//  SignUpController1.swift
//  travel
//
//  Created by Lin Jin on 9/21/24.
//

import UIKit

class SignUpController1: UIViewController {
    
    var receivedText: String? // This will hold the text passed from WelcomeController2
    
    // MARK: - Properties (view)
    private let textLabel = UILabel()
    private let progressBarImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the style for the label
        
        view.backgroundColor = .systemBackground
        
        setupTextLabel()
        setupProgressBarImageView()
    }
    
    private func setupProgressBarImageView() {
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
        progressBarImageView.image = UIImage(named: "progressBar1")
            
        view.addSubview(progressBarImageView)
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                progressBarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
                progressBarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                progressBarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                progressBarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            ])
        }
    
    // MARK: - Properties (data)
    private func setupTextLabel(){
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = receivedText
        textLabel.font = UIFont.boldSystemFont(ofSize: 32)
        textLabel.textAlignment = .center
        textLabel.textColor = .black
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 103),
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

        ])
    }
    
    


    // MARK: - Change Views
    
}
