//
//  ViewController.swift
//  Flashcard
//
//  Created by Al Shafian Bari on 2/26/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFlashcard(question:"How much stars are in the Sky?", answer: " 50 billion")
    }

    @IBAction func didTaponFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
       updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        //Adding flashcard in the flashcards array
        flashcards.append(flashcard)
        
        print( " Added new flashcards")
        print( " we now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("our current index is \(currentIndex)")
    updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
        
                frontLabel.text = question
                backLabel.text = answer
                frontLabel.textAlignment = .center
                backLabel.textAlignment = .center
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count + 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        if currentIndex == flashcards.count - 1 {
            prevButton.isEnabled = true
        } else {
            prevButton.isEnabled = false
        }
    }
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(flashcards, forKey: "flashcards")
        print("Flash saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        
        let saveCards = dictionaryArray.map  { dictionary -> Flashcard in
            return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashcards()
        if flashcards.count == 0 {
            updateFlashcard(question: <#T##String#>, answer: <#T##String#>)
            
            else {
                updateLabels()
                updateNextPrevButtons()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let navigationController = segue.destination as! UINavigationController
           let creationController = navigationController.topViewController as! CreationViewController
           
           creationController.flashcardsController = self
       }
}

