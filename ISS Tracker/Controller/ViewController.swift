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
        return label.createLabel(text: "[Coordinates]")
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
        return label.createLabel(text: "[Coordinates]")
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
    
    var defineISSButton: UIButton = {
        let button = UIButton(type: .system)
        button.target(forAction: #selector(defineISS), withSender: self)
        button.setTitle("What is ISS?", for: .normal)
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 15)
        button.frame.size = CGSize.init(width: 50, height: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        view.addSubview(defineISSButton)
        
        implementAutolayout()
    }
    
    //MARK: Autolayouts
    func implementAutolayout() {
        //Implementing Auto Layout
        NSLayoutConstraint.activate([
            trackISSButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            trackISSButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            trackISSButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            trackISSButton.heightAnchor.constraint(equalToConstant: 60),
            
            defineISSButton.topAnchor.constraint(equalTo: ISSHeaderLabel.layoutMarginsGuide.bottomAnchor),
            defineISSButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
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
    
    //MARK:- Target Actions.
    //action to retrieve the coordinates.
    @objc
    func doSomeThing() {
        
        
        
        guard let url = URL(string: "http://api.open-notify.org/iss-now.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                debugPrint(response.statusCode)
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard let jsonData = try? jsonDecoder.decode(ApiModel.self, from: data!) else {
                print("Could not decode ")
                return
            }
            
            self.convertCoordinates(lat: jsonData.iss_position.latitude, long: jsonData.iss_position.longitude)
            
            DispatchQueue.main.async {
                self.longitudeValueLabel.text = jsonData.iss_position.longitude
                self.latitudeValueLabel.text = jsonData.iss_position.latitude
            }
        }.resume()
        
    }
    
    func convertCoordinates(lat: String, long: String) {
        
        let location = CLLocation(latitude: Double(Float(lat)!), longitude: Double(Float(long)!))
        geocode(location: location) { (placemark, error) in
            if error != nil {
                return
            }
            
            
        }
    }
    
    func geocode(location: CLLocation, completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            guard let placemark = placemark, error == nil else {
                completion(nil, error)
                return
            }
            completion(placemark, nil)
        }
    }
    
    @objc
    func defineISS() {
        
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
