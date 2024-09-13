//
//  ViewController.swift
//  travel
//
//  Created by Lin Jin on 9/3/24.
//
import SwiftUI
import UIKit

class ViewController: UIViewController {
    let appLabel = UILabel()
    let carImageView = UIImageView()
    let lineView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the items :)
        view.addSubview(appLabel)
        view.addSubview(carImageView)

        // Set the style for the label
        
        setupLineView()
        setupAppLabel()
        setupcarImageView()
    }
    
    private func setupAppLabel(){
        appLabel.translatesAutoresizingMaskIntoConstraints = false
        appLabel.text = "StuGo"
        appLabel.font = UIFont.boldSystemFont(ofSize: 32)
        appLabel.textAlignment = .center
        appLabel.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            appLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 395),
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLabel.widthAnchor.constraint(equalToConstant: 97),
            appLabel.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
    private func setupcarImageView() {
            carImageView.translatesAutoresizingMaskIntoConstraints = false
            carImageView.image = UIImage(named: "car")
            
            view.addSubview(carImageView)
            carImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                carImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 483),
                carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                carImageView.widthAnchor.constraint(equalToConstant: 56),
                carImageView.heightAnchor.constraint(equalToConstant: 55.67)
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

}

