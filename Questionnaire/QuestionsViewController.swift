//
//  QuestionsViewController.swift
//  Questionnaire
//
//  Created by Вероника Садовская on 06.09.2018.
//  Copyright © 2018 Veronika Sadovskaya. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
	
	
	@IBOutlet weak var qustionLabel: UILabel!
	
	@IBOutlet weak var singleStackView: UIStackView!
	@IBOutlet weak var singleButton1: UIButton!
	@IBOutlet weak var singleButton2: UIButton!
	@IBOutlet weak var singleButton3: UIButton!
	@IBOutlet weak var singleButton4: UIButton!
	
	@IBOutlet weak var multipleStackView: UIStackView!
	@IBOutlet weak var multiLable1: UILabel!
	@IBOutlet weak var multiLable2: UILabel!
	@IBOutlet weak var multiLable3: UILabel!
	@IBOutlet weak var multiLable4: UILabel!
	@IBOutlet weak var multiSwitch1: UISwitch!
	@IBOutlet weak var multiSwitch2: UISwitch!
	@IBOutlet weak var multiSwitch3: UISwitch!
	@IBOutlet weak var multiSwitch4: UISwitch!
	
	@IBOutlet weak var rangedStackView: UIStackView!
	@IBOutlet weak var rangedLabel1: UILabel!
	@IBOutlet weak var rangedLabel2: UILabel!
	@IBOutlet weak var rangerSlider: UISlider!
	
	@IBOutlet weak var questionProgressView: UIProgressView!
	
	@IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
		let currentAnswers = questions[questionIndex].answers
		switch sender {
		case singleButton1:
			answerChosen.append(currentAnswers[0])
		case singleButton2:
			answerChosen.append(currentAnswers[1])
		case singleButton3:
			answerChosen.append(currentAnswers[2])
		case singleButton4:
			answerChosen.append(currentAnswers[3])
		default:
			break
		}
		nextQuestion()
	}
	
	@IBAction func multipleAnswerButtonPressed() {
	let currentAnswers = questions[questionIndex].answers
		if multiSwitch1.isOn {
			answerChosen.append(currentAnswers[0])
		}
		if multiSwitch2.isOn {
			answerChosen.append(currentAnswers[1])
		}
		if multiSwitch3.isOn {
			answerChosen.append(currentAnswers[2])
		}
		if multiSwitch4.isOn {
			answerChosen.append(currentAnswers[3])
		}
		nextQuestion()
	}
	@IBAction func rangerAnswerButtonPressed() {
		let currentAnswers = questions[questionIndex].answers
		let index = Int(round(rangerSlider.value * Float(currentAnswers.count - 1)))
		answerChosen.append(currentAnswers[index])
		nextQuestion()
	}
	var questions: [Question] = [
		Question (text: "Какая еда вам нравиться?",
				  type: .single,
				  answers: [
					Answer(text: "Стейк", type: .dog),
					Answer(text: "Рыба", type: .cat),
					Answer(text: "Морковка", type: .rabbit),
					Answer(text: "Кукуруза", type: .turtle)
			]),
		Question (text: "Что вам нравиться делать?",
				  type: .multiple,
				  answers: [			Answer(text: "Есть", type: .dog),
										Answer(text: "Спать", type: .cat),
										Answer(text: "Прыгать", type: .rabbit),
										Answer(text: "Плавать", type: .turtle)
			]),
		Question (text: "На сколько вам нравяться поездки на машине",
				  type: .ranged,
				  answers: [
					Answer(text: "Ненавижу их", type: .cat),
					Answer(text: "Немного нервничаю", type: .rabbit),
					Answer(text: "Почти не замечаю", type: .turtle),
					Answer(text: "Обожаю их", type: .dog)
			])
	]
	
	var questionIndex = 0
	var answerChosen: [Answer] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		updateUI()
	}
	
	func updateUI() {
		singleStackView.isHidden = true
		multipleStackView.isHidden = true
		rangedStackView.isHidden = true
		
		navigationItem.title = "Вопрос № \(questionIndex + 1)"
		let currentQuestion = questions[questionIndex]
		let currentAnswers = currentQuestion.answers
		let totalProgress = Float(questionIndex) / Float(questions.count)
		qustionLabel.text = currentQuestion.text
		questionProgressView.setProgress(totalProgress, animated: true)
		
		switch currentQuestion.type {
		case .single:
			updateSingleStackView(using: currentAnswers)
		case .multiple:
			updateMultipleStackView(using: currentAnswers)
		case .ranged:
			updateRangerStackView(using: currentAnswers)
		}
	}
	
	func updateSingleStackView(using answers: [Answer]) {
		singleStackView.isHidden = false
		singleButton1.setTitle(answers[0].text, for: .normal)
		singleButton2.setTitle(answers[1].text, for: .normal)
		singleButton3.setTitle(answers[2].text, for: .normal)
		singleButton4.setTitle(answers[3].text, for: .normal)
	}
	
	func updateMultipleStackView(using answers: [Answer]) {
		multipleStackView.isHidden = false
		multiSwitch1.isOn = false
		multiSwitch2.isOn = false
		multiSwitch3.isOn = false
		multiSwitch4.isOn = false
		multiLable1.text = answers[0].text
		multiLable2.text = answers[1].text
		multiLable3.text = answers[2].text
		multiLable4.text = answers[3].text
	}
	
	func updateRangerStackView(using answers: [Answer]) {
		rangedStackView.isHidden = false
		rangerSlider.setValue(0.5, animated: true)
		rangedLabel1.text = answers.first?.text
		rangedLabel2.text = answers.last?.text
	}
	
	func nextQuestion() {
	questionIndex += 1
		if questionIndex < questions.count {
			updateUI()
		} else {
			performSegue(withIdentifier: "ResultsSegue", sender: nil)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ResultsSegue" {
			let resultsViewController = segue.destination as! ResultsViewController
			resultsViewController.responses = answerChosen
		}
	}
}
