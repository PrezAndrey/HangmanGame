//
//  FinishViewController.swift
//  HangmanGame
//
//  Created by Андрей  on 29.06.2023.
//

import UIKit

class FinishViewController: UIViewController {
    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var gussedWord: UILabel!
    @IBOutlet weak var tries: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    @IBAction func didDismiss(_ sender: Any) {
    }
    @IBAction func didConfirm(_ sender: Any) {
    }
}

extension FinishViewController {
    private func configureScreen() {
        guard let game = game else { return }
        imageView.image = UIImage(named: "h" + String(game.tries))
        tries.text = "You have \(game.tries) tries left"
        gussedWord.text = "The guessed word is \(game.chosenWord.uppercased())"
        if game.wordCompletion == game.chosenWord {
            result.text = "YOU WIN!!!"
            screenView.backgroundColor = .green
        }
        else {
            result.text = "YOU LOSE =("
            screenView.backgroundColor = .red
        }
    }
}
