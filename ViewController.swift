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
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readSavedFlashcards()
        if flashcards.count == 0 {
        updateFlashcard(question:"How much stars are in the Sky?", answer: " 50 billion")
    }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTaponFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    func flipFlashcard() {
            if(frontLabel.isHidden == false) {
                frontLabel.isHidden = true
                
                UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: { self.frontLabel.isHidden = true})
                
            } else {
                frontLabel.isHidden = false
                
                UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: { self.frontLabel.isHidden = false})
            }
            
            }
        
        func animateCardOut() {
            UIView.animate(withDuration: 0.2, animations: { self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0) }, completion: { finished in
                
                self.updateLabels()
                
                self.animateCardIn()
                
            })
        }
    
    func animateCardIn() {
           card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
           
           UIView.animate(withDuration: 0.4) {
               self.card.transform = CGAffineTransform.identity
           }
       }
       
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
       //updateLabels()
        updateNextPrevButtons()
        animateCardOut()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        animateCardIn()
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
        
            // From flashcard array to dictionary array
            let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
            }
        
            // Save array on siak using UserDefaults
            UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
            
            // Log
            print("🎉 Flashcards saved to UserDefaults")
        }
        
    
    func readSavedFlashcards() {
           if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
               
               let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                   return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
               }
               
               flashcards.append(contentsOf: savedCards)
           }
    }
    

    
    
    @IBAction func didTapOnDelete(_ sender: Any) {
           
           // Show confirmation
           let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete flashcard?", preferredStyle: .actionSheet)
           
           // Create delete action and add to the alert
           let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
               self.deleteCurrentFlashcard()
           }
           alert.addAction(deleteAction)
           
           // Create cancel action and add to the alert
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
           alert.addAction(cancelAction)
           
           // Present the alert
           present(alert, animated: true)
       }
       
       
       func deleteCurrentFlashcard () {
           
           // Delete flashcard at the current index if not the only remaining card
           if flashcards.count != 1 {
               flashcards.remove(at: currentIndex)
           }
           
           // Special case: check if last card deleted
           if currentIndex > flashcards.count - 1 {
               currentIndex = flashcards.count - 1
           }
           
           updateLabels()
           updateNextPrevButtons()
           saveAllFlashcardsToDisk()
       }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let navigationController = segue.destination as! UINavigationController
           let creationController = navigationController.topViewController as! CreationViewController
           
           creationController.flashcardsController = self
       }


}
