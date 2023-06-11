//
//  GameViewController.swift
//  HangmanGame
//
//  Created by Андрей  on 28.05.2023.
//

import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordCompletion: UILabel!
    @IBOutlet weak var tries: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didCheck(_ sender: Any) {
    }
}
