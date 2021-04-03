//
//  ViewController.swift
//  Flashcards
//
//  Created by Queenie Lau on 2/20/21.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class flashcardsController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var card: UIView!
    
    @IBAction func tappedOnNext(_ sender: Any) {
        curr_flashcardIndex += 1
        updateLabels()
        updateNextPrevButtons()
        animateCardOut()
    }
    
    @IBAction func tappedOnPrev(_ sender: Any) {
        curr_flashcardIndex -= 1
        updateLabels()
        updateNextPrevButtons()
        animateCardOut()

    }
    
    var flashcard_array = [Flashcard]()
    
    // Current flashcard index
    var curr_flashcardIndex = 0
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        readSavedFlashcards()
        // Do any additional setup after loading the view.
        
        if(flashcard_array.count == 0) {
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    func updateNextPrevButtons() {
        if(curr_flashcardIndex == flashcard_array.count - 1){
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        
        if(curr_flashcardIndex == 0){
            prevButton.isEnabled = false
        }
        
        else{
            prevButton.isEnabled = true
        }
    }
    

    @IBAction func didTapOnFlashcard(_ sender: Any) {
       flipFlashcard()
    }
    
    func flipFlashcard() {
        if(frontLabel.isHidden){
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.frontLabel.isHidden = false
                self.backLabel.isHidden = false
            })
        }
        else{
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
                self.frontLabel.isHidden = true
            })
        }
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardIn()
        })
    }
    
    func animateCardIn() {
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func updateLabels() {
        let currFlashcard = flashcard_array[curr_flashcardIndex]
        frontLabel.text = currFlashcard.question
        backLabel.text = currFlashcard.answer

    }
    
    func updateFlashcard(question: String, answer: String) {
        let fc = Flashcard(question: question, answer: answer)
        flashcard_array.append(fc)
        curr_flashcardIndex = flashcard_array.count - 1
        updateNextPrevButtons()
        updateLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardController = self
    }
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = flashcard_array.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer]}
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readSavedFlashcards() {
        let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards")
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)}
            flashcard_array.append(contentsOf: savedCards)
        }
    }
    
}
