//
//  ViewController.swift
//  Flashcard
//
//  Created by Al Shafian Bari on 2/26/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTaponFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
                backLabel.text = answer
                
                frontLabel.textAlignment = .center
                backLabel.textAlignment = .center
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let navigationController = segue.destination as! UINavigationController
           let creationController = navigationController.topViewController as! CreationViewController
           
           creationController.flashcardsController = self
       }
}
