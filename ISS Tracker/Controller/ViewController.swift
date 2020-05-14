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
    
    //ISS Header on the top of the screen
    var ISSHeaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "ISS Coordinates"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Stack View to contain Longitude and its value text
    var longStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.autoresizingMask = .flexibleRightMargin
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var LongitudeLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "Longitude: ")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
    }
    
    func initializeUI() {
        view.backgroundColor = .white
        
        longStackView.addArrangedSubview(LongitudeLabel)
        
        view.addSubview(trackISSButton)
        view.addSubview(ISSHeaderLabel)
        view.addSubview(longStackView)
        
        NSLayoutConstraint.activate([
            trackISSButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            trackISSButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            trackISSButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            ISSHeaderLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            ISSHeaderLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 45),
            
            longStackView.topAnchor.constraint(equalTo: ISSHeaderLabel.bottomAnchor, constant: 40)
        ])
        
        let longStackViewWidth = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stackView]-20-|", options: .alignAllCenterX, metrics: nil, views: ["stackView": longStackView])
        
        view.addConstraints(longStackViewWidth)
    }
    
    @objc
    func doSomeThing() {
    }

}


extension UILabel {
    func createLabel(text: String) -> UILabel {
        self.text = text
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 15)
        self.adjustsFontSizeToFitWidth = true
        
        return self
    }
}
