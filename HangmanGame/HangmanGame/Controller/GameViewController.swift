//
//  GameViewController.swift
//  HangmanGame
//
//  Created by Андрей  on 28.05.2023.
//

import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordCompletion: UILabel!
    @IBOutlet weak var tries: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var textfield: UITextField!

    var letterArray: [String] = []
    var wordArray: [String] = []
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startNewGame()
    }
    
    
    @IBAction func didCheck(_ sender: Any) {
        view.endEditing(true)
        let text = checkTextfield(text: textfield.text)
        checkUserInput(input: text)
        print(game.wordCompletion)
        checkTries(tries: game.tries)
    }
}

extension GameViewController {
    
    func startNewGame() {
        letterArray = []
        wordArray = []
        game = Game()
        configureWord()
        
    }
    
    private func checkUserInput(input: String) {
        let userInput = input
        guard userInput != "" else { return }
        
        if userInput.count == 1 {
            if isValid(letter: Character(userInput)) && !letterArray.contains(userInput) {
                mainView.backgroundColor = .green
                letterArray.append(userInput)
                message.text = "You are right! Open the letter"
                game.wordCompletion = game.openLetter(completion: game.wordCompletion, word: game.chosenWord, letter: Character(userInput))
                configureScreeen()
            }
            else {
                if letterArray.contains(userInput) {
                    mainView.backgroundColor = .blue
                    message.text = "Incorrect! You have used this letter, try another one"
                    self.textfield.text = ""
                }
                else {
                    mainView.backgroundColor = .red
                    message.text = "You are wrong! You have lost your try"
                    letterArray.append(userInput)
                    let imageName = game.mistake(tries: &game.tries)
                    imageView.image = UIImage(named: imageName)
                    tries.text = "\(game.tries)"
                }
            }
        }
        else {
            if game.chosenWord == userInput {
                wordCompletion.text = userInput
                game.wordCompletion = userInput
                message.text = "YOU WIN!!!"
                mainView.backgroundColor = .green
            }
            else {
                if wordArray.contains(userInput) {
                    message.text = "You have used this word before! Try another one!"
                    mainView.backgroundColor = .blue
                }
                else {
                    mainView.backgroundColor = .red
                    message.text = "You are wrong! You have lost your try"
                    wordArray.append(userInput)
                    let imageName = game.mistake(tries: &game.tries)
                    imageView.image = UIImage(named: imageName)
                    tries.text = "\(game.tries)"
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.mainView.backgroundColor = UIColor(named: "defaultColor")
            self.message.text = "Enter a letter or a whole word"
            self.textfield.text = ""
        }
    }
    
    private func configureWord() {
        game.chosenWord = game.chooseRandomWord()
        imageView.image = UIImage(named: "h6")
        var completion = ""
        for _ in game.chosenWord.indices {
            completion += "_"
        }
        game.wordCompletion = completion
        configureScreeen()
    }
    
    private func configureScreeen() {
        wordCompletion.text = refactorCompletion(completion: game.wordCompletion)
        tries.text = String(game.tries)
    }
    
    private func refactorCompletion(completion: String) -> String {
        var newCompletion = ""
        
        for char in completion {
            newCompletion += String(char) + " "
        }
        
        return newCompletion
    }
    
    private func isValid(letter: Character) -> Bool {
        game.chosenWord.contains(letter)
    }
    
    private func checkTextfield(text: String?) -> String {
        guard let text = text?.lowercased() else {return ""}
        return text
    }
    
    private func checkTries(tries: Int) {
        if tries < 1 || game.wordCompletion == game.chosenWord {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.performSegue(withIdentifier: "result", sender: nil)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FinishViewController {
            destination.game = self.game
        }
    }
        
}
