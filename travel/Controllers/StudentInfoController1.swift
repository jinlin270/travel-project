//
//  StudentInfoController1.swift
//  travel
//
//  Created by Lin Jin on 9/22/24.
//

import Foundation

import UIKit

class StudentInfoController1: UIViewController {

    var receivedText: String? // This will hold the text passed from WelcomeController2
    
    // MARK: - Properties (view)
    private let thankYouLabel = UILabel()
    private let learnMoreLabel = UILabel()
    private let progressBarImageView = UIImageView()
    private let preferredNameTextField = UITextField()
    private let pronounsTextField = UITextField()
    private let phoneTextField = UITextField()
    private let homeTownTextField = UITextField()
    private let backButton = UIButton()
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the style for the label
        
        view.backgroundColor = .systemBackground
        
        setupProgressBarImageView()
        setupthankYouLabel()
        setupLearnMoreLabel()
        setupTextFields()
        setupBackButton()
        setupNextButton()
    }
    
    private func setupProgressBarImageView() {
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
        progressBarImageView.image = UIImage(named: "progressBar2")
            
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
    private func setupthankYouLabel(){
        thankYouLabel.translatesAutoresizingMaskIntoConstraints = false
        thankYouLabel.text = "Thank you for signing up!"
        thankYouLabel.font = UIFont.systemFont(ofSize: 16)
        thankYouLabel.textAlignment = .center
        thankYouLabel.textColor = .black
        view.addSubview(thankYouLabel)
        NSLayoutConstraint.activate([
            thankYouLabel.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 42),
            thankYouLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

        ])
    }
    
    private func setupLearnMoreLabel() {
        learnMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        learnMoreLabel.text = "This is Student Info"
        learnMoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        learnMoreLabel.textAlignment = .left
        learnMoreLabel.textColor = .black
        learnMoreLabel.numberOfLines = 0 // Allow for multiple lines
        view.addSubview(learnMoreLabel)
        
        NSLayoutConstraint.activate([
            learnMoreLabel.topAnchor.constraint(equalTo: thankYouLabel.bottomAnchor, constant: 14),
            learnMoreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            learnMoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16), // Add trailing constraint
            learnMoreLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0) // Optional, to allow height to adjust
        ])
    }

    
    private func setupTextFields() {
            let textFieldContainer = UIView()
            textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
            
            // Configure text fields
            configureTextField(preferredNameTextField, placeholder: "Preferred Name")
            configureTextField(pronounsTextField, placeholder: "Pronouns")
            configureTextField(phoneTextField, placeholder: "Phone Number")
            configureTextField(homeTownTextField, placeholder: "Hometown")
            
            // Add all text fields to the container
            textFieldContainer.addSubview(preferredNameTextField)
            textFieldContainer.addSubview(pronounsTextField)
            textFieldContainer.addSubview(phoneTextField)
            textFieldContainer.addSubview(homeTownTextField)
            
            view.addSubview(textFieldContainer)

            // Set up constraints for the text fields
            NSLayoutConstraint.activate([
                // Container view constraints
                textFieldContainer.topAnchor.constraint(equalTo: learnMoreLabel.bottomAnchor, constant: 56),
                textFieldContainer.widthAnchor.constraint(equalToConstant: 361), // Fixed width
                textFieldContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor) // Center horizontally
                
                // Each text field constraints
            ])
            
            let textFieldHeight: CGFloat = 56
            
            NSLayoutConstraint.activate([
                preferredNameTextField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor),
                preferredNameTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
                preferredNameTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
                preferredNameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

                pronounsTextField.topAnchor.constraint(equalTo: preferredNameTextField.bottomAnchor, constant: 24),
                pronounsTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
                pronounsTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
                pronounsTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

                phoneTextField.topAnchor.constraint(equalTo: pronounsTextField.bottomAnchor, constant: 24),
                phoneTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
                phoneTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
                phoneTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
                
                homeTownTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 24),
                homeTownTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
                homeTownTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
                homeTownTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
                // Make sure the container view has enough height to accommodate all text fields
                textFieldContainer.bottomAnchor.constraint(equalTo: homeTownTextField.bottomAnchor)
            ])
        }
    
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        // Configure the text field
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        
        let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black // Placeholder text color
            ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        // Set padding inside the text field
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
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
        // Switch to StudentInfoController1
        let studentInfoController2 = StudentInfoController2()
        // Assuming you are using a navigation controller
        navigationController?.pushViewController(studentInfoController2, animated: true)
        // If not using a navigation controller, you can use:
        // present(studentInfoController, animated: true, completion: nil)
    }

    @objc private func backButtonTapped() {
        // Switch to StudentInfoController1
        let signupController = SignUpController1()
        // Assuming you are using a navigation controller
        navigationController?.pushViewController(signupController, animated: true)
        // If not using a navigation controller, you can use:
        // present(studentInfoController, animated: true, completion: nil)
    }
    // MARK: - Change Views
    
}
