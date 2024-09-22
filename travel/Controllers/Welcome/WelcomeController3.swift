//
//  WelcomeController3.swift
//  travel
//
//  Created by Lin Jin on 9/29/24.
//

import UIKit
class WelcomeController3: UIViewController {
    
    // MARK: - Properties (view)
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let connectingLabel = UILabel()
    
    private let progressBarImageView = UIImageView()
    private let pageImageView = UIImageView()
    private let nextButton = UIButton()
    private let backButton = UIButton()
    
    // MARK: - viewDidLoad and init

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        setupProgressBarImageView()
        setupPageImageView()
        setupTitleLabel()
        setupDetailsLabel()
        setupNextButton()
        setupConnectingLabel()
    }
    
    private func setupProgressBarImageView() {
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
        progressBarImageView.image = UIImage(named: "progressBar2")
            
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
        pageImageView.image = UIImage(named: "welcomePageArt2")
        
        view.addSubview(pageImageView)
        pageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageImageView.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 63),
            pageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageImageView.widthAnchor.constraint(equalToConstant: 394)
        ])
        }

    
    private func setupTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Discover, Share, Connect"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: pageImageView.topAnchor, constant: 80),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    
    private func setupConnectingLabel() {
        view.addSubview(connectingLabel)
        connectingLabel.translatesAutoresizingMaskIntoConstraints = false
        connectingLabel.text = "Campus Connecting"
        connectingLabel.font = UIFont.systemFont(ofSize: 16)
        connectingLabel.textAlignment = .center
        connectingLabel.textColor = .black
        connectingLabel.numberOfLines = 0 // Allow label to wrap text on multiple lines
        
        // Set line break mode to word wrap (default is by word)
        connectingLabel.lineBreakMode = .byWordWrapping

        NSLayoutConstraint.activate([
            connectingLabel.topAnchor.constraint(equalTo: pageImageView.bottomAnchor, constant: 18.1), // Optional padding
            connectingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectingLabel.widthAnchor.constraint(equalToConstant: 338) // Set label width to 338
        ])
    }
    
    private func setupDetailsLabel() {
        view.addSubview(detailsLabel)
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.text = "Your All-in-One Ride Hub for Finding, Offering, and Requesting Rides!"
        detailsLabel.font = UIFont.systemFont(ofSize: 16)
        detailsLabel.textAlignment = .center
        detailsLabel.textColor = UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0)
        detailsLabel.numberOfLines = 0 // Allow label to wrap text on multiple lines
        
        // Set line break mode to word wrap (default is by word)
        detailsLabel.lineBreakMode = .byWordWrapping

        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 346), // Optional padding
            detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsLabel.widthAnchor.constraint(equalToConstant: 338) // Set label width to 338
        ])
    }


    
    private func setupNextButton() {
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0), for: .normal)
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 24
        backButton.layer.borderColor = UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0).cgColor
        backButton.layer.borderWidth = 2
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Configure the back button
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.white, for: .normal) // Set title color to black
        nextButton.backgroundColor = UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0)
 // Background color is clear

        // Add rounded corners
        nextButton.layer.cornerRadius = 24
        nextButton.layer.borderColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.0).cgColor

        nextButton.layer.borderWidth = 1 // Set stroke width

        // Add target for action
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        // Add button to the view

        let stackView = UIStackView(arrangedSubviews: [backButton, nextButton])
            stackView.axis = .horizontal
            stackView.alignment = .top // Align buttons to the top
            stackView.spacing = 171 // Set spacing between the buttons
            stackView.distribution = .fillEqually // Distribute equally

            // Add stack view to the view
            view.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false

        // Set up button constraints
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func backButtonTapped() {
        // Switch to StudentInfoController1
        let welcomeController2 = WelcomeController2()
        // Assuming you are using a navigation controller
        navigationController?.pushViewController(welcomeController2, animated: true)
        // If not using a navigation controller, you can use:
        // present(studentInfoController, animated: true, completion: nil)
    }

    @objc private func nextButtonTapped() {
        // Switch to StudentInfoController1
        let welcomeController4 = WelcomeController4()
        // Assuming you are using a navigation controller
        navigationController?.pushViewController(welcomeController4, animated: true)
        // If not using a navigation controller, you can use:
        // present(studentInfoController, animated: true, completion: nil)
    }

    // MARK: - Button Helpers
}
