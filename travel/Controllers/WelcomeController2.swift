//
//  WelcomeController2.swift
//  travel
//
//  Created by Lin Jin on 9/12/24.
//

import UIKit

class WelcomeController2: UIViewController {
    
    // MARK: - Properties (view)
    private let welcomeLabel = UILabel()
    private let missionLabel = UILabel()
    private let whiteBox = UIView()
    private let signUpLabel = UILabel()
    private let logInLabel = UILabel()
    private let instructorButton = UIButton()
    private let studentButton = UIButton()
    private let parentButton = UIButton()
    private let textField = UITextField()
    private let googleImageView = UIImageView()
    private let ssoLabel = UILabel()
    private let googleButton = UIButton()
    private let ssoButton = UIButton()
    
    // MARK: - viewDidLoad and init

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        
        setupWelcomeLabel()
        setupMissionLabel()
        setupSignUpLabel()
        setupInstructorButton()
        setupStudentButton()
        setupParentButton()
        setupLogInLabel()
        setupGoogleImageView()
        setupGoogleButton()
        setupSSOButton()
        setupssoLabel()
        setupWhiteBox()
    }
    
    private func setupWelcomeLabel(){
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Welcome to StuGo"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 32)
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 228),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    private func setupMissionLabel(){
        view.addSubview(missionLabel)
        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.text = "Your Destination, Our Connection"
        missionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        missionLabel.textAlignment = .center
        missionLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            missionLabel.topAnchor.constraint(equalTo:  view.topAnchor, constant: 276),
            missionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    private func setupWhiteBox() {
        whiteBox.translatesAutoresizingMaskIntoConstraints = false
        whiteBox.backgroundColor = .white
        
        // Add the whiteBox to the view hierarchy
        view.addSubview(whiteBox)
        view.sendSubviewToBack(whiteBox)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            whiteBox.topAnchor.constraint(equalTo: view.topAnchor, constant: 401),
            whiteBox.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            whiteBox.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteBox.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSignUpLabel(){
        view.addSubview(signUpLabel)
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.text = "Sign up as an"
        signUpLabel.font = UIFont.systemFont(ofSize: 16)
        signUpLabel.textAlignment = .center
        signUpLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: missionLabel.bottomAnchor, constant: 126),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    private func setupLogInLabel(){
        view.addSubview(logInLabel)
        logInLabel.translatesAutoresizingMaskIntoConstraints = false
        logInLabel.text = "or login with"
        logInLabel.font = UIFont.systemFont(ofSize: 16)
        logInLabel.textAlignment = .center
        logInLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            logInLabel.topAnchor.constraint(equalTo: parentButton.bottomAnchor, constant: 24),
            logInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }

    private func setupInstructorButton() {
        instructorButton.translatesAutoresizingMaskIntoConstraints = false
        instructorButton.setTitle("Instructor", for: .normal) // Set your button title
        instructorButton.setTitleColor(.black, for: .normal) // Set the title color

        // Set the background color
        instructorButton.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)

        // Set the corner radius
        instructorButton.layer.cornerRadius = 4

        // Add shadows
        instructorButton.layer.shadowColor = UIColor.black.cgColor
        instructorButton.layer.shadowOpacity = 0.15
        instructorButton.layer.shadowRadius = 1.5
        instructorButton.layer.shadowOffset = CGSize(width: 0, height: 1)

        // Additional shadow
        instructorButton.layer.shadowOpacity = 0.3
        instructorButton.layer.shadowRadius = 1
        instructorButton.layer.shadowOffset = CGSize(width: 0, height: 1)

        // Add to view hierarchy
        view.addSubview(instructorButton)

        // Set up constraints
        NSLayoutConstraint.activate([
            instructorButton.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 24),
            instructorButton.widthAnchor.constraint(equalToConstant: 290),
            instructorButton.heightAnchor.constraint(equalToConstant: 56),
            instructorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        instructorButton.addTarget(self, action: #selector(instructorButtonPressed), for: .touchUpInside)
    }
    

    private func setupStudentButton() {
        studentButton.translatesAutoresizingMaskIntoConstraints = false
        studentButton.setTitle("Student", for: .normal) // Set your button title
        studentButton.setTitleColor(.black, for: .normal) // Set the title color

        // Set the background color
        studentButton.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)

        // Set the corner radius
        studentButton.layer.cornerRadius = 4

        // Add shadows
        studentButton.layer.shadowColor = UIColor.black.cgColor
        studentButton.layer.shadowOpacity = 0.15
        studentButton.layer.shadowRadius = 1.5
        studentButton.layer.shadowOffset = CGSize(width: 0, height: 1)

        // Additional shadow
        studentButton.layer.shadowOpacity = 0.3
        studentButton.layer.shadowRadius = 1
        studentButton.layer.shadowOffset = CGSize(width: 0, height: 1)

        // Add to view hierarchy
        view.addSubview(studentButton)

        // Set up constraints
        NSLayoutConstraint.activate([
            studentButton.topAnchor.constraint(equalTo: instructorButton.bottomAnchor, constant: 16),
            studentButton.widthAnchor.constraint(equalToConstant: 290),
            studentButton.heightAnchor.constraint(equalToConstant: 56),
            studentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        studentButton.addTarget(self, action: #selector(studentButtonPressed), for: .touchUpInside)
    }
    
    
    private func setupParentButton() {
        parentButton.translatesAutoresizingMaskIntoConstraints = false
        parentButton.setTitle("Parent", for: .normal) // Set your button title
        parentButton.setTitleColor(.black, for: .normal) // Set the title color

        // Set the background color
        parentButton.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)

        // Set the corner radius
        parentButton.layer.cornerRadius = 4

        // Add shadows
        parentButton.layer.shadowColor = UIColor.black.cgColor
        parentButton.layer.shadowOpacity = 0.15
        parentButton.layer.shadowRadius = 1.5
        parentButton.layer.shadowOffset = CGSize(width: 0, height: 1)

        // Additional shadow
        parentButton.layer.shadowOpacity = 0.3
        parentButton.layer.shadowRadius = 1
        parentButton.layer.shadowOffset = CGSize(width: 0, height: 1)

        // Add to view hierarchy
        view.addSubview(parentButton)

        // Set up constraints
        NSLayoutConstraint.activate([
            parentButton.topAnchor.constraint(equalTo: studentButton.bottomAnchor, constant: 16),
            parentButton.widthAnchor.constraint(equalToConstant: 290),
            parentButton.heightAnchor.constraint(equalToConstant: 56),
            parentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        parentButton.addTarget(self, action: #selector(parentButtonPressed), for: .touchUpInside)
    }

    @objc private func instructorButtonPressed() {
            // Set the text field to the button's title
            textField.text = instructorButton.title(for: .normal)
            
            // Transition to SignUpController1
            let signUpController = SignUpController1()
            signUpController.receivedText = textField.text // Pass the text to the next controller
            navigationController?.pushViewController(signUpController, animated: true)
        }
    
    @objc private func studentButtonPressed() {
            // Set the text field to the button's title
            textField.text = studentButton.title(for: .normal)
            
            // Transition to SignUpController1
            let signUpController = SignUpController1()
            signUpController.receivedText = textField.text // Pass the text to the next controller
            navigationController?.pushViewController(signUpController, animated: true)
        }
    
    @objc private func parentButtonPressed() {
            // Set the text field to the button's title
            textField.text = parentButton.title(for: .normal)
            
            // Transition to SignUpController1
            let signUpController = SignUpController1()
            signUpController.receivedText = textField.text // Pass the text to the next controller
            navigationController?.pushViewController(signUpController, animated: true)
        }
    
    private func setupGoogleImageView() {
            googleImageView.translatesAutoresizingMaskIntoConstraints = false
            googleImageView.image = UIImage(named: "googleIcon")
            
            view.addSubview(googleImageView)
            googleImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                googleImageView.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 22),
                googleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -215),
                googleImageView.widthAnchor.constraint(equalToConstant: 20),
                googleImageView.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
    
    private func setupGoogleButton() {
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the button's image
        googleButton.setImage(UIImage(named: "iconCircle"), for: .normal)
        
        // Set the button's frame (optional, since you're using Auto Layout)
        googleButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32) // Set size of the button

        // Set background color to white
        googleButton.backgroundColor = .white
        
        // Round corners for circular appearance
        googleButton.layer.cornerRadius = 16 // Half of the height (32/2)
        
        // Add shadow to the button
        googleButton.layer.shadowColor = UIColor.black.cgColor
        googleButton.layer.shadowOpacity = 0.15
        googleButton.layer.shadowRadius = 1.5
        googleButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        // Additional shadow
        googleButton.layer.shadowOpacity = 0.3
        googleButton.layer.shadowRadius = 1
        googleButton.layer.shadowOffset = CGSize(width: 0, height: 1)

        // Add the button to the view
        view.addSubview(googleButton)

        // Set up constraints
        NSLayoutConstraint.activate([
            googleButton.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 16), // Position below the logInLabel
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -209), // Align to the right
            googleButton.widthAnchor.constraint(equalToConstant: 32), // Fixed width
            googleButton.heightAnchor.constraint(equalToConstant: 32) // Fixed height
        ])

        // Send the googleButton behind the logInLabel
        view.sendSubviewToBack(googleButton)
    }

    
    private func setupssoLabel(){
        view.addSubview(logInLabel)
        ssoLabel.translatesAutoresizingMaskIntoConstraints = false
        ssoLabel.text = "SSO"
        ssoLabel.font = UIFont.systemFont(ofSize: 12)
        ssoLabel.textAlignment = .center
        ssoLabel.textColor = .black
        view.addSubview(ssoLabel)
        
        NSLayoutConstraint.activate([
            ssoLabel.topAnchor.constraint(equalTo: ssoButton.topAnchor, constant: 8),
            ssoLabel.trailingAnchor.constraint(equalTo: ssoButton.trailingAnchor, constant: -4),
        ])
    }
    
    
    private func setupSSOButton() {
            ssoButton.translatesAutoresizingMaskIntoConstraints = false
            
            // Set the button's image
            ssoButton.setImage(UIImage(named: "iconCircle"), for: .normal)
            ssoButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32) // Set size of the button

            // Set background color to white
            ssoButton.backgroundColor = .white
            ssoButton.layer.cornerRadius = 16
                
            // Add shadow to the button
            ssoButton.layer.shadowColor = UIColor.black.cgColor
            ssoButton.layer.shadowOpacity = 0.15
            ssoButton.layer.shadowRadius = 1.5
            ssoButton.layer.shadowOffset = CGSize(width: 0, height: 1)
                    
                // Additional shadow
            ssoButton.layer.shadowOpacity = 0.3
            ssoButton.layer.shadowRadius = 1
            ssoButton.layer.shadowOffset = CGSize(width: 0, height: 1)

            // Add the button to the view
            view.addSubview(ssoButton)
            view.sendSubviewToBack(ssoButton)

            // Set up constraints
            NSLayoutConstraint.activate([
                ssoButton.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 16), // Adjust the position as needed
                ssoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -153),
                ssoButton.widthAnchor.constraint(equalToConstant: 32),
                ssoButton.heightAnchor.constraint(equalToConstant: 32)
            ])
        }
    
    // MARK: - Button Helpers
}
