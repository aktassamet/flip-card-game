//
//  MemoryGameViewController.swift
//  Flip_Card_Game
//
//  Created by samet on 14.03.2019.
//  Copyright © 2019 Fundev. All rights reserved.
//

import Foundation
import UIKit

final class MemoryGameViewController: UIViewController, Layouting, AlertShowing {
	
	convenience init(_ level: Level) {
		self.init()
		self.level = level
		cards = Card.cards(forLevel: level)
	}

	// MARK: - Variables
	private var flippedIndexPaths: [IndexPath] = []
	private var sucessCount = 0
	private var shouldFlip = true
	private var level: Level?
	private var cards: [Card] = []

	typealias ViewType = MemoryGameView

	override func loadView() {
		view = ViewType.create()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.collectionView.dataSource = self
		layoutableView.collectionView.delegate = self

		layoutableView.levelButton.addTarget(self, action: #selector(didTapLevelButton), for: .touchUpInside)

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
		guard let cell = layoutableView.collectionView.dequeueReusableCell(withReuseIdentifier: "MemoryGameCollectionViewCell", for: indexPath) as? MemoryGameCollectionViewCell else { return UICollectionViewCell() }
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

// MARK: - Game Helpers
private extension MemoryGameViewController {

	func setupGame() {
		let cells = layoutableView.collectionView.visibleCells
		cells.forEach { value in
			guard let cell = value as? MemoryGameCollectionViewCell else { return }
			cell.flip()
			cell.isLocked = false
			sucessCount = 0
		}
		guard let layout = layoutableView.collectionView.collectionViewLayout as? MemoryGameCollectionViewLayout else { return }
		guard let level = self.level else { return }
		layout.level = level.rawValue
	}

	func flipCell(at indexPath: IndexPath) {
		guard let cell = layoutableView.collectionView.cellForItem(at: indexPath) as? MemoryGameCollectionViewCell else { return }
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
		guard let currentCell = layoutableView.collectionView.cellForItem(at: currentIndexPath) as? MemoryGameCollectionViewCell else { return }

		let previousIndexPath = flippedIndexPaths[0]
		guard let previousCell = layoutableView.collectionView.cellForItem(at: previousIndexPath) as? MemoryGameCollectionViewCell else { return }

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

	func successCheck() {
		guard sucessCount ==  cards.count / 2 else { return }
		DispatchQueue.main.asyncAfter(deadline: .now() + MemoryGameCollectionViewCell.duration) {
			self.showAlert(title: "Success", message: "Game Finished", actionTitle: "Play Again") {
				self.refreshGame()
			}
		}
	}

}

// MARK: - Actions
extension MemoryGameViewController {

	@objc func didTapLevelButton() {

		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		alert.addAction(UIAlertAction(title: "Easy", style: .default, handler: { [weak self] _ in
			guard let self = self else { return }
			self.level = .easy
			self.refreshGame()
		}))

		alert.addAction(UIAlertAction(title: "Medium", style: .default, handler: { [weak self] _ in
			guard let self = self else { return }
			self.level = .medium
			self.refreshGame()
		}))

		alert.addAction(UIAlertAction(title: "Hard", style: .default, handler: { [weak self] _ in
			guard let self = self else { return }
			self.level = .hard
			self.refreshGame()
		}))

		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		self.present(alert, animated: true)
	}

	func refreshGame() {

		cards = Card.cards(forLevel: level ?? .medium)
		flippedIndexPaths.removeAll()
		shouldFlip = true
		sucessCount = 0

		guard let layout = layoutableView.collectionView.collectionViewLayout as? MemoryGameCollectionViewLayout else { return }
		guard let level = self.level else { return }
		layout.level = level.rawValue

		layoutableView.collectionView.reloadData()

	}
}
