//
//  Question.swift
//  Questionnaire
//
//  Created by Вероника Садовская on 12.09.2018.
//  Copyright © 2018 Veronika Sadovskaya. All rights reserved.
//

import Foundation

struct Question {
	var text: String
	var type: ResponseType
	var answers: [Answer]
}

enum ResponseType {
	case single, multiple, ranged
}

struct Answer {
	var text: String
	var type: AnimalType
}

enum AnimalType: Character {
	case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
	
	var definition: String {
		switch self {
		case .dog:
			return "Вы окружаете себя людьми, которые вым нравяться и любите проводить время с друзьями"
		case .cat:
			return "Вам нравиться делать все самостоятельно"
		case .rabbit:
			return "Вам нравиться все мягкое, вы здоровы и полны энергии"
		case .turtle:
			return "Вы не по годам умны и любите вникать в детали. Медленный и аккуратный выигрывает"
		
		}
	}
}
