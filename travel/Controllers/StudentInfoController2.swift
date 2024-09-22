//
//  StudentInfoController2.swift
//  travel
//
//  Created by Lin Jin on 9/22/24.
//

import Foundation

import UIKit
import SwiftUI

class StudentInfoController2: UIViewController {

    var receivedText: String? // This will hold the text passed from WelcomeController2
    
    // MARK: - Properties (view)
    private let questionLabel = UILabel()
    private let progressBarImageView = UIImageView()
    private let backButton = UIButton()
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the style for the label
        
        view.backgroundColor = .systemBackground
        
        setupProgressBarImageView()
        setupQuestionLabel()
        setupBackButton()
        setupNextButton()
    }
    
    private func setupProgressBarImageView() {
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
        progressBarImageView.image = UIImage(named: "progressBar3")
            
        view.addSubview(progressBarImageView)
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                progressBarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
                progressBarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                progressBarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                progressBarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            ])
        }
    
    
    private func setupQuestionLabel() {
    questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = "Do you have a car?"
        questionLabel.font = UIFont.boldSystemFont(ofSize: 24)
        questionLabel.textAlignment = .left
        questionLabel.textColor = .black
        questionLabel.numberOfLines = 0 // Allow for multiple lines
        view.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 64),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16), // Add trailing constraint
            questionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0) // Optional, to allow height to adjust
        ])
    }


    private func setupBackButton() {
        // Configure the back button
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal) // Set title color to black
        backButton.backgroundColor = .clear // Background color is clear

        // Add rounded corners
        backButton.layer.cornerRadius = 8
        backButton.layer.borderColor = UIColor.black.cgColor // Add black stroke
        backButton.layer.borderWidth = 1 // Set stroke width

        // Add target for action
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Add button to the view
        view.addSubview(backButton)

        // Set up button constraints
        NSLayoutConstraint.activate([
            // Center the button horizontally and align it towards the bottom with 120pt space from the bottom
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 120), // Width expanded to 120 for better text visibility
            backButton.heightAnchor.constraint(equalToConstant: 40)  // Height set to 40
        ])
    }
    
    private func setupNextButton() {
        // Configure the back button
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.white, for: .normal) // Set title color to black
        nextButton.backgroundColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.0) // Background color is clear

        // Add rounded corners
        nextButton.layer.cornerRadius = 8
        nextButton.layer.borderColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.0).cgColor

        nextButton.layer.borderWidth = 1 // Set stroke width

        // Add target for action
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        // Add button to the view
        view.addSubview(nextButton)

        // Set up button constraints
        NSLayoutConstraint.activate([
            // Center the button horizontally and align it towards the bottom with 120pt space from the bottom
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nextButton.widthAnchor.constraint(equalToConstant: 120), // Width expanded to 120 for better text visibility
            nextButton.heightAnchor.constraint(equalToConstant: 40)  // Height set to 40
        ])
    }

    @objc private func nextButtonTapped() {
        let signupController = SignUpController1()
        navigationController?.pushViewController(signupController, animated: true)

    }

    @objc private func backButtonTapped() {
        let onboardingController1 = OnboardingController1() // SwiftUI view
        let hostingController = UIHostingController(rootView: onboardingController1) // Wrap SwiftUI view in UIHostingController
        navigationController?.pushViewController(hostingController, animated: true)
    }


    // MARK: - Change Views
    
}
