//
//  Card.swift
//  Flip_Card_Game
//
//  Created by samet on 13.03.2019.
//  Copyright © 2019 Fundev. All rights reserved.
//

import UIKit

struct Card: Equatable {

	var image: UIImage

	enum Face: CaseIterable {
		case front
		case back
	}

}

public enum Level: Int {
	case easy = 1
	case medium = 2
	case hard = 3
}

extension Card {

	static func numberOfCards(forLevel level: Int) -> Int {
		return numberOfRows(forLevel: level) * numberOfColumns(forLevel: level)
	}

	static func cards(forLevel level: Level) -> [Card] {
		let cards = all.shuffled().prefix(numberOfCards(forLevel: level.rawValue) / 2)
		return cards.shuffled() + cards.shuffled()
	}

	static func numberOfRows(forLevel level: Int) -> Int {
		switch level {
		case 1:
			return 2
		case 2:
			return 3
		case 3:
			return 4
		default:
			return 0
		}
	}

	static func numberOfColumns(forLevel level: Int) -> Int {
		switch level {
		case 1:
			return 2
		case 2:
			return 2
		case 3:
			return 3
		default:
			return 0
		}
	}

	static var all: [Card] {
		return [
			.init(image: #imageLiteral(resourceName: "iconMemoryGameBedCard")),
			.init(image: #imageLiteral(resourceName: "iconMemoryGameWomanCard")),
			.init(image: #imageLiteral(resourceName: "iconMemoryGameSheepCard")),
			.init(image: #imageLiteral(resourceName: "iconMemoryGameWindowCard")),
			.init(image: #imageLiteral(resourceName: "iconMemoryGameMoonCard")),
			.init(image: #imageLiteral(resourceName: "iconMemoryGameClockCard"))
		]
	}

}
