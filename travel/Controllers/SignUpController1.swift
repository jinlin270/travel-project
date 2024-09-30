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
    private let schoolTextField = UITextField()
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let studentIDTextField = UITextField()
    private let signUpButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the style for the label
        
        view.backgroundColor = .systemBackground
        
        setupTextLabel()
        setupProgressBarImageView()
        setupTextFields()
        setupSignUpButton()
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
    
    private func setupTextFields() {
            let textFieldContainer = UIView()
            textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
            
            // Configure text fields
            configureTextField(schoolTextField, placeholder: "School")
            configureTextField(nameTextField, placeholder: "Name")
            configureTextField(emailTextField, placeholder: "Educational Email")
            configureTextField(studentIDTextField, placeholder: "Student ID Number")
            
            // Add all text fields to the container
            textFieldContainer.addSubview(schoolTextField)
            textFieldContainer.addSubview(nameTextField)
            textFieldContainer.addSubview(emailTextField)
            textFieldContainer.addSubview(studentIDTextField)
            
            view.addSubview(textFieldContainer)

            // Set up constraints for the text fields
            NSLayoutConstraint.activate([
                // Container view constraints
                textFieldContainer.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 72),
                textFieldContainer.widthAnchor.constraint(equalToConstant: 361), // Fixed width
                textFieldContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor) // Center horizontally
                
                // Each text field constraints
            ])
            
            let textFieldHeight: CGFloat = 56
            
            NSLayoutConstraint.activate([
                schoolTextField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor),
                schoolTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
                schoolTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
                schoolTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

                nameTextField.topAnchor.constraint(equalTo: schoolTextField.bottomAnchor, constant: 24),
                nameTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
                nameTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
                nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

                emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
                emailTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
                emailTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
                emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
                
                studentIDTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
                studentIDTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
                studentIDTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
                studentIDTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
                // Make sure the container view has enough height to accommodate all text fields
                textFieldContainer.bottomAnchor.constraint(equalTo: studentIDTextField.bottomAnchor)
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

    
    private func setupSignUpButton() {
        // Configure the sign-up button
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.0)
        signUpButton.layer.cornerRadius = 8
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        // Add button to the view
        view.addSubview(signUpButton)

        // Set up button constraints
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: studentIDTextField.bottomAnchor, constant: 72),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 361),
            signUpButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc private func signUpButtonTapped() {
        // Switch to StudentInfoController1
        let studentInfoController = StudentInfoController1()
        // Assuming you are using a navigation controller
        navigationController?.pushViewController(studentInfoController, animated: true)
        // If not using a navigation controller, you can use:
        // present(studentInfoController, animated: true, completion: nil)
    }
    // MARK: - Change Views
    
}
