//
//  QuestionScreen.swift
//  PersonalityQuiz
//
//  Created by Mikolaj Lukasik on 14/08/2019.
//  Copyright © 2019 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class QuestionScreen: UIViewController {
    
    var questionIndex = 0
    
    var questions: [Question] = [
        Question(
            text: "How do you brush your teeth?",
            type: .single,
            answers: [
                Answer(text: "Bravely!", type: .gryffindor),
                Answer(text: "While eating a sandwich.", type: .hufflepuff),
                Answer(text: "While reading a book.", type: .ravenclaw),
                Answer(text: "I am a snake, ssss…", type: .slytherin),
            ]
        ),
        Question(
            text: "Which of those do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Dueling", type: .gryffindor),
                Answer(text: "Helping others", type: .hufflepuff),
                Answer(text: "Learning new things", type: .ravenclaw),
                Answer(text: "Treasure hunting", type: .slytherin),
            ]
        ),
        Question(
            text: "How much do you enjoy car rides?",
            type: .ranged,
            answers: [
                Answer(text: "I dislike them", type: .gryffindor),
                Answer(text: "I love them", type: .hufflepuff),
                Answer(text: "I get a little nervous", type: .ravenclaw),
                Answer(text: "I barely notice them", type: .slytherin),
            ]
        ),
        
    ]
    
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet var multipleStackView: UIStackView!
    
    @IBOutlet var rangedStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        
        navigationItem.title = "Question #\(questionIndex+1)"
        
        let currentQuestion = questions[questionIndex]
        
        switch currentQuestion.type {
        case .single:
            singleStackView.isHidden = false
        case .multiple:
            multipleStackView.isHidden = false
        case .ranged:
            rangedStackView.isHidden = false
        }
        
        
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
