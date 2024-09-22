//
//  WelcomeController4.swift
//  travel
//
//  Created by Lin Jin on 9/29/24.
//

import Foundation
import UIKit
import SwiftUI
class WelcomeController4: UIViewController {
    
    // MARK: - Properties (view)
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let missionLabel = UILabel()
    
    private let progressBarImageView = UIImageView()
    private let pageImageView = UIImageView()
    private let backButton = UIButton()
    private let hillImageView = UIImageView()
    private let smolCarImageView = UIImageView()
    private let googleButton = UIButton()
    private let googleIconImageView = UIImageView()
    private let googleIconContainerView = UIView()
    private let googleButtonLabel = UILabel()
    private let googleButtonContainer = UIStackView()
    
    // MARK: - viewDidLoad and init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        setupProgressBarImageView()
        setupPageImageView()
        setupTitleLabel()
        setupMissionLabel()
        setupDetailsLabel()
        setupBackButton()
        setupHillImageView()
        setupCarImageView()
        setupGoogleButton()
    }
    
    private func setupProgressBarImageView() {
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
        progressBarImageView.image = UIImage(named: "progressBar3")
            
        view.addSubview(progressBarImageView)
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                progressBarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                progressBarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                progressBarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                progressBarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        }
    
    private func setupPageImageView() {
        pageImageView.translatesAutoresizingMaskIntoConstraints = false
        pageImageView.image = UIImage(named: "welcomePageArt3")
        
        view.addSubview(pageImageView)
        pageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageImageView.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 136),
            pageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageImageView.widthAnchor.constraint(equalToConstant: 394)
        ])
        }

    private func setupHillImageView() {
        hillImageView.translatesAutoresizingMaskIntoConstraints = false
        hillImageView.image = UIImage(named: "hill")
        
        view.addSubview(hillImageView)
        hillImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hillImageView.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 450),
            hillImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            hillImageView.widthAnchor.constraint(equalToConstant: 710.5)
        ])
        }
    
    private func setupCarImageView() {
        smolCarImageView.translatesAutoresizingMaskIntoConstraints = false
        smolCarImageView.image = UIImage(named: "smallCar")
        
        view.addSubview(smolCarImageView)
        smolCarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            smolCarImageView.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 514.77),
            smolCarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 219.77),
            smolCarImageView.widthAnchor.constraint(equalToConstant: 27),
            smolCarImageView.heightAnchor.constraint(equalToConstant: 27)
        ])
        }
    
    private func setupTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "StuGo"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 52),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    private func setupMissionLabel() {
        view.addSubview(missionLabel)
        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.text = "Your Destination, Our Connection"
        missionLabel.font = UIFont.systemFont(ofSize: 16)
        missionLabel.textAlignment = .center
        missionLabel.textColor = .black

        NSLayoutConstraint.activate([
            missionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8), // Optional padding
            missionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            missionLabel.widthAnchor.constraint(equalToConstant: 338) // Set label width to 338
        ])
    }
    
    private func setupDetailsLabel() {
        view.addSubview(detailsLabel)
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.text = "Sign in with your education account to ride with your peers"
        detailsLabel.font = UIFont.systemFont(ofSize: 16)
        detailsLabel.textAlignment = .center
        detailsLabel.textColor = .black
        detailsLabel.numberOfLines = 0 // Allow label to wrap text on multiple lines
        
        // Set line break mode to word wrap (default is by word)
        detailsLabel.lineBreakMode = .byWordWrapping

        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 294), // Optional padding
            detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsLabel.widthAnchor.constraint(equalToConstant: 283) // Set label width to 338
        ])
    }

    private func setupGoogleButton() {
        // Configure the Google button stack view
        googleButtonContainer.axis = .horizontal
        googleButtonContainer.spacing = 8
        googleButtonContainer.alignment = .center
        googleButtonContainer.translatesAutoresizingMaskIntoConstraints = false

        // Set up the container view for the icon
        googleIconContainerView.translatesAutoresizingMaskIntoConstraints = false
        googleIconContainerView.backgroundColor = .white
        googleIconContainerView.layer.cornerRadius = 12
        googleIconContainerView.clipsToBounds = true

        // Set up the image view
        googleIconImageView.translatesAutoresizingMaskIntoConstraints = false
        googleIconImageView.image = UIImage(named: "googleIcon")
        googleIconImageView.contentMode = .scaleAspectFit

        // Add the image view inside the container view
        googleIconContainerView.addSubview(googleIconImageView)

        // Add the icon container and the text to the stack view
        googleButtonContainer.addArrangedSubview(googleIconContainerView)

        // Set up the label for the button text
        googleButtonLabel.text = "SIGN IN WITH GOOGLE"
        googleButtonLabel.textColor = .white
        googleButtonLabel.font = UIFont.boldSystemFont(ofSize: 16)
        googleButtonLabel.translatesAutoresizingMaskIntoConstraints = false

        googleButtonContainer.addArrangedSubview(googleButtonLabel)

        // Add the stack view to the main button view
        googleButton.addSubview(googleButtonContainer)

        // Set up the button styling
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.backgroundColor = UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0)
        googleButton.layer.cornerRadius = 24
        googleButton.layer.borderColor = UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0).cgColor
        googleButton.layer.borderWidth = 2
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)

        // Add the button to the view
        view.addSubview(googleButton)
        let tapGestureButtonContainer = UITapGestureRecognizer(target: self, action: #selector(googleButtonTapped))
        googleButtonContainer.addGestureRecognizer(tapGestureButtonContainer)
        googleButtonContainer.isUserInteractionEnabled = true // Enable interaction
        
        // Set up button constraints
        NSLayoutConstraint.activate([
            googleButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 24),
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleButton.widthAnchor.constraint(equalToConstant: 257),
            googleButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        // Set up the container view constraints (for the icon)
        NSLayoutConstraint.activate([
            googleIconContainerView.widthAnchor.constraint(equalToConstant: 24),
            googleIconContainerView.heightAnchor.constraint(equalToConstant: 24)
        ])

        // Set up the image view constraints (centered inside the container)
        NSLayoutConstraint.activate([
            googleIconImageView.centerXAnchor.constraint(equalTo: googleIconContainerView.centerXAnchor),
            googleIconImageView.centerYAnchor.constraint(equalTo: googleIconContainerView.centerYAnchor),
            googleIconImageView.widthAnchor.constraint(equalToConstant: 20),
            googleIconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Set constraints for the stack view inside the button
        NSLayoutConstraint.activate([
            googleButtonContainer.centerXAnchor.constraint(equalTo: googleButton.centerXAnchor),
            googleButtonContainer.centerYAnchor.constraint(equalTo: googleButton.centerYAnchor),
        ])
        
        // Make sure any overlapping views do not intercept touches
        googleButtonContainer.isUserInteractionEnabled = true
    }

    @objc private func googleButtonTapped() {
        let onboardingController1 = UIHostingController(rootView: OnboardingController1())
        navigationController?.pushViewController(onboardingController1, animated: true)
    }

    private func setupBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false // Ensure Auto Layout is used

        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0), for: .normal)
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 24
        backButton.layer.borderColor = UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0).cgColor
        backButton.layer.borderWidth = 2
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Add the button to the view
        view.addSubview(backButton)

        // Set up button constraints
        NSLayoutConstraint.activate([
            // Adjust the top constraint to avoid pushing the button too far down
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    
    @objc private func backButtonTapped() {
        // Switch to StudentInfoController1
        let welcomeController3 = WelcomeController3()
        // Assuming you are using a navigation controller
        navigationController?.pushViewController(welcomeController3, animated: true)
        // If not using a navigation controller, you can use:
        // present(studentInfoController, animated: true, completion: nil)
    }

    // MARK: - Button Helpers
}
