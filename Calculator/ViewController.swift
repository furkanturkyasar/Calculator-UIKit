//
//  ViewController.swift
//  Calculator
//
//  Created by Furkan Türkyaşar on 22.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        resultLabel.text = "0"
    }
    
    
    @IBAction func clearPressed(_ sender: UIButton) {
        resultLabel.text = "0"
    }
    
}

