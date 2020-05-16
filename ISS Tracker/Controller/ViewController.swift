//
//  ViewController.swift
//  ISS Tracker
//
//  Created by Moazzam Tahir on 13/05/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    //MARK: UI Elements are declared here.
    var trackISSButton: UIButton = {
        let trackButton = UIButton(type: .system)
        trackButton.setTitle("Track 🚀", for: .normal)
        trackButton.setTitleColor(.white, for: .normal)
        trackButton.backgroundColor = .gray
        trackButton.layer.cornerRadius = 30
        trackButton.layer.shadowColor = UIColor.darkGray.cgColor
        trackButton.layer.shadowOffset = .init(width: 2, height: 4)
        trackButton.layer.shadowRadius = 5
        trackButton.layer.shadowOpacity = 0.6
        trackButton.translatesAutoresizingMaskIntoConstraints = false
        trackButton.addTarget(self, action: #selector(doSomeThing), for: .touchUpInside)
        
        return trackButton
    }()
    
    //ISS Header on the top of the screen
    var ISSHeaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "ISS Coordinates 🛰 "
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
    
    //longitude Text
    var LongitudeLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "Longitude: ")
    }()
    
    //longitude Value Label that will be retrieved from API
    var longitudeValueLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "34.1039")
    }()
    
    //Stack View to contain Latitude and its value text
    var latStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.autoresizingMask = .flexibleRightMargin
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    //latitude Text
    var latitudeLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "Latitude: ")
    }()
    
    //latitude Value Label that will be retrieved from API
    var latitudeValueLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "51.4689")
    }()
    
    //Coordinates translation Label
    var coordinateTranslationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Coordinates Translation"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
    }
    
    func initializeUI() {
        view.backgroundColor = .white
        //Adding Views to the Stack Views.
        longStackView.addArrangedSubview(LongitudeLabel)
        longStackView.addArrangedSubview(longitudeValueLabel)
        
        latStackView.addArrangedSubview(latitudeLabel)
        latStackView.addArrangedSubview(latitudeValueLabel)
        
        //Adding views to the parent view.
        view.addSubview(trackISSButton)
        view.addSubview(ISSHeaderLabel)
        view.addSubview(longStackView)
        view.addSubview(latStackView)
        view.addSubview(coordinateTranslationLabel)
        
        //Implementing Auto Layout
        NSLayoutConstraint.activate([
            trackISSButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            trackISSButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            trackISSButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            trackISSButton.heightAnchor.constraint(equalToConstant: 60),
            
            ISSHeaderLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            ISSHeaderLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 45),
            
            longStackView.topAnchor.constraint(equalTo: ISSHeaderLabel.bottomAnchor, constant: 40),
            
            latStackView.topAnchor.constraint(equalTo: longStackView.bottomAnchor, constant: 20),
            
            coordinateTranslationLabel.topAnchor.constraint(equalTo: latStackView.bottomAnchor, constant: 30),
            
            coordinateTranslationLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
        
        let longStackViewWidth = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stackView]-20-|", options: .alignAllCenterX, metrics: nil, views: ["stackView": longStackView])
        let latStackViewWidth = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stackView]-20-|", options: .alignAllCenterX, metrics: nil, views: ["stackView": latStackView])
        
        view.addConstraints(longStackViewWidth)
        view.addConstraints(latStackViewWidth)
    }
    
    
    
    @objc
    func doSomeThing() {
//        guard let longitudeValue = longitudeValueLabel.text else {return}
//        let long = CLLocationDegrees(exactly: Double(longitudeValue)!)
//
//        guard let latitudeValue = latitudeValueLabel.text else {return}
//        let lat = CLLocationDegrees(exactly: Double(latitudeValue)!)
//
//        let location = CLLocation(latitude: lat!, longitude: long!)
//
//        let address = CLGeocoder.init()
//        address.reverseGeocodeLocation(location) { (places, error) in
//            guard let _ = error else {
//                print("Error translating coordinates")
//                return
//            }
//
//            if let place = places {
//                print(place)
//            }
//        }
//
        guard let url = URL(string: "http://api.open-notify.org/iss-now.json") else { return }
    }

}


extension UILabel {
    func createLabel(text: String) -> UILabel {
        self.text = text
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 20)
        self.adjustsFontSizeToFitWidth = true
        
        return self
    }
}
