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
    private let detailsLabel = UILabel()
    
    private let progressBarImageView = UIImageView()
    private let pageImageView = UIImageView()
    private let nextButton = UIButton()
    
    // MARK: - viewDidLoad and init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        setupProgressBarImageView()
        setupPageImageView()
        setupWelcomeLabel()
        setupDetailsLabel()
        setupNextButton()
    }
    
    private func setupProgressBarImageView() {
        progressBarImageView.translatesAutoresizingMaskIntoConstraints = false
        progressBarImageView.image = UIImage(named: "progressBar1")
            
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
        pageImageView.image = UIImage(named: "welcomePageArt1")
        
        view.addSubview(pageImageView)
        view.sendSubviewToBack(pageImageView)
        pageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageImageView.topAnchor.constraint(equalTo: progressBarImageView.bottomAnchor, constant: 63),
            pageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageImageView.widthAnchor.constraint(equalToConstant: 394)
        ])
        }

    
    private func setupWelcomeLabel(){
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Fuel Your Journey - StuGo"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 604),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    private func setupDetailsLabel() {
        view.addSubview(detailsLabel)
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.text = "Empowering Students to Share Rides, Create Memories & Embrace New Horizons!"
        detailsLabel.font = UIFont.systemFont(ofSize: 16)
        detailsLabel.textAlignment = .center
        detailsLabel.textColor = .black
        detailsLabel.numberOfLines = 0 
        detailsLabel.lineBreakMode = .byWordWrapping

        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8), // Optional padding
            detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsLabel.widthAnchor.constraint(equalToConstant: 338) // Set label width to 338
        ])
    }
    
    private func setupNextButton() {
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
        view.addSubview(nextButton)

        // Set up button constraints
        NSLayoutConstraint.activate([
            // Center the button horizontally and align it towards the bottom with 120pt space from the bottom
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nextButton.widthAnchor.constraint(equalToConstant: 100), // Width expanded to 120 for better text visibility
            nextButton.heightAnchor.constraint(equalToConstant: 48)  // Height set to 40
        ])
    }

    @objc private func nextButtonTapped() {
        // Switch to StudentInfoController1
        let welcomeController3 = WelcomeController3()
        // Assuming you are using a navigation controller
        navigationController?.pushViewController(welcomeController3, animated: true)
        // If not using a navigation controller, you can use:
        // present(studentInfoController, animated: true, completion: nil)
    }

    // MARK: - Button Helpers
}
