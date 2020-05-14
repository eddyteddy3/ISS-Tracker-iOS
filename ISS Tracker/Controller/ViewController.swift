//
//  ViewController.swift
//  ISS Tracker
//
//  Created by Moazzam Tahir on 13/05/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: UI Elements are declared here.
    var trackISSButton: UIButton = {
        let trackButton = UIButton(type: .system)
        trackButton.setTitle("Track ISS", for: .normal)
        trackButton.backgroundColor = .magenta
        trackButton.layer.cornerRadius = 5
        trackButton.translatesAutoresizingMaskIntoConstraints = false
        trackButton.addTarget(self, action: #selector(doSomeThing), for: .touchUpInside)
        
        return trackButton
    }()
    
    var ISSHeaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "ISS Coordinates"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initializeUI()
    }
    
    func initializeUI() {
        view.addSubview(trackISSButton)
        view.addSubview(ISSHeaderLabel)
        
        NSLayoutConstraint.activate([
            trackISSButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            trackISSButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            trackISSButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            ISSHeaderLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            ISSHeaderLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 45)
        ])
    }
    
    @objc
    func doSomeThing() {
    }

}

