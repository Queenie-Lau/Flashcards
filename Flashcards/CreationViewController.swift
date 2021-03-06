//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Queenie Lau on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var flashcardController: flashcardsController!
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTaponDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        if(questionText != nil && answerText != nil) {
            flashcardController.updateFlashcard(question: questionText!, answer: answerText!)
            dismiss(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
