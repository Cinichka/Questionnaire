//
//  ResultsViewController.swift
//  Questionnaire
//
//  Created by Вероника Садовская on 06.09.2018.
//  Copyright © 2018 Veronika Sadovskaya. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
	
	@IBOutlet weak var resultAnswerLabel: UILabel!
	@IBOutlet weak var resultDefinitionLabel: UILabel!
	
	var responses: [Answer]!
	override func viewDidLoad() {
		super.viewDidLoad()
		calculatePersonalityResult()
		navigationItem.hidesBackButton = true
		print(responses)
	}
	
	func calculatePersonalityResult() {
		var frequencyOfAnswers: [AnimalType: Int] = [:]
		let responseTypes = responses.map {$0.type}
		for response in responseTypes {
			frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
		}
		let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
		
		resultAnswerLabel.text = "Вы — это \(mostCommonAnswer.rawValue)!"
		resultDefinitionLabel.text = mostCommonAnswer.definition
	}
	
}
