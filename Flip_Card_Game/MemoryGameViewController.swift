//
//  MemoryGameViewController.swift
//  Flip_Card_Game
//
//  Created by samet on 14.03.2019.
//  Copyright © 2019 Fundev. All rights reserved.
//

import Foundation
import UIKit
final class MemoryGameViewController: UIViewController {

	private var level: Int?
	private var cards: [Card] = []
	convenience init(level: Int) {
		self.init()
		self.level = level
		cards = Card.cards(forLevel: level)
	}

	private var flippedIndexPaths: [IndexPath] = []
	private var sucessCount = 0
	private var shouldFlip = true

	typealias ViewType = GameView

	var gameView = GameView(frame: UIScreen.main.bounds)

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(gameView)

		gameView.collectionView.dataSource = self
		gameView.collectionView.delegate = self

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		setupGame()
	}

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MemoryGameViewController: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cards.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = gameView.collectionView.dequeueReusableCell(withReuseIdentifier: "MemoryGameCollectionViewCell", for: indexPath) as! MemoryGameCollectionViewCell
		cell.configure(for: cards[indexPath.item])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		flipCell(at: indexPath)
	}

	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		flipCell(at: indexPath)
	}

}

// MARK: - Helpers
private extension MemoryGameViewController {

	func flipCell(at indexPath: IndexPath) {
		guard let cell = gameView.collectionView.cellForItem(at: indexPath) as? MemoryGameCollectionViewCell else { return }
		guard !cell.isLocked else { return }
		guard shouldFlip else { return }

		shouldFlip = false
		cell.flip()

		if flippedIndexPaths.isEmpty {
			flippedIndexPaths.append(indexPath)
			shouldFlip = true
		} else {
			openTwoCards(currentIndexPath: indexPath)
		}
	}

	func openTwoCards(currentIndexPath: IndexPath) {
		guard flippedIndexPaths.first == currentIndexPath else {
			flipCheck(currentIndexPath: currentIndexPath)
			return
		}
		flippedIndexPaths.removeAll()
		shouldFlip = true
	}

	func flipCheck(currentIndexPath: IndexPath) {
		guard let currentCell = gameView.collectionView.cellForItem(at: currentIndexPath) as? MemoryGameCollectionViewCell else { return }

		let previousIndexPath = flippedIndexPaths[0]
		guard let previousCell = gameView.collectionView.cellForItem(at: previousIndexPath) as? MemoryGameCollectionViewCell else { return }

		if cards[currentIndexPath.row] == cards[previousIndexPath.item] {
			currentCell.isLocked = true
			previousCell.isLocked = true
			flippedIndexPaths.removeAll()
			sucessCount += 1
			shouldFlip = true
			successCheck()
		} else {
			flippedIndexPaths.removeAll()
			DispatchQueue.main.asyncAfter(deadline: .now() + MemoryGameCollectionViewCell.duration) {
				currentCell.flip()
				previousCell.flip()
				self.shouldFlip = true
			}
		}
	}

	func setupGame() {
		let cells = gameView.collectionView.visibleCells
		cells.forEach { value in
			let cell = value as? MemoryGameCollectionViewCell
			cell?.flip()
			cell?.isLocked = false
			sucessCount = 0
		}
		let layout = gameView.collectionView.collectionViewLayout as? MemoryGameCollectionViewLayout
		layout?.level = level
		gameView.collectionView.reloadData()
	}

	func successCheck() {
		guard sucessCount ==  cards.count / 2 else { return }
		DispatchQueue.main.asyncAfter(deadline: .now() + MemoryGameCollectionViewCell.duration) {
			let alert = UIAlertController(title: "Success", message: "Game Finished", preferredStyle: .alert)

			let okAction = UIAlertAction(title: "Play Again", style: .default) { _ in
				self.setupGame()
			}
			alert.addAction(okAction)
			self.present(alert, animated: true, completion: nil)
		}
	}

}

