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
    var tapButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initializeUI()
    }
    
    func initializeUI() {
        
        tapButton = UIButton(type: .system)
        tapButton?.setTitle("Track ISS", for: .normal)
        tapButton?.backgroundColor = .magenta
        tapButton?.layer.cornerRadius = 5
        tapButton?.translatesAutoresizingMaskIntoConstraints = false
        tapButton?.addTarget(self, action: #selector(doSomeThing), for: .touchUpInside)
        
        view.addSubview(tapButton!)
        
        NSLayoutConstraint.activate([
            tapButton!.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tapButton!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            tapButton!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc
    func doSomeThing() {
    }

}

