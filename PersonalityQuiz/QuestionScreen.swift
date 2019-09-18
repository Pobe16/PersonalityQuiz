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
                Answer(text: "I get a little nervous", type: .ravenclaw),
                Answer(text: "I barely notice them", type: .slytherin),
                Answer(text: "I love them", type: .hufflepuff),
            ]
        ),
        
    ]
    
    var answersChosen: [Answer] = []
    
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetQuestionControls()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        resetQuestions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationItem.title = "Restart"
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
    
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
        
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func resetQuestionControls() {
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        rangedSlider.setValue(0.5, animated: false)
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            resetQuestionControls()
            updateUI()
        } else {
            performSegue(withIdentifier: "showResults", sender: nil)
        }
    }
    
    func resetQuestions() {
        questionIndex = 0
        answersChosen = []
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
        
    }
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults"{
            let resultsViewController = segue.destination as! ResultScreen
            resultsViewController.responses = answersChosen
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
