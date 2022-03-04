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
}

