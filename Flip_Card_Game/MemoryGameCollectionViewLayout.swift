//
//  MemoryGameCollectionViewLayout.swift
//  Flip_Card_Game
//
//  Created by samet on 13.03.2019.
//  Copyright © 2019 Fundev. All rights reserved.
//

import Foundation
import UIKit

final class MemoryGameCollectionViewLayout: UICollectionViewFlowLayout {

	var level: Int? {
		didSet {
			prepare()
		}
	}

	override func prepare() {
		super.prepare()

		guard let aLevel = level else { return }
		guard let frame = collectionView?.frame else { return }
		guard frame != .zero else { return }

		scrollDirection = .vertical
		var isColumnDivide: Bool
		var insetHorizontal: CGFloat = 0
		var insetVertical: CGFloat = 0
		let width: CGFloat
		let height: CGFloat

		let row = Card.numberOfRows(forLevel: aLevel)
		let column = Card.numberOfColumns(forLevel: aLevel)

		isColumnDivide = (frame.size.width / CGFloat(column)) < (frame.size.height / CGFloat(row))

		if isColumnDivide {
			width = frame.size.width / CGFloat(column)
			height = frame.size.width / CGFloat(column)
			insetVertical = frame.size.height - height * CGFloat(row)
		} else {
			width = frame.size.height / CGFloat(row)
			height = frame.size.height / CGFloat(row)
			insetHorizontal = frame.size.width - (width * CGFloat(column))
		}

		itemSize = CGSize(width: width, height: height)
		minimumInteritemSpacing = 0
		minimumLineSpacing = 0

		sectionInset = UIEdgeInsets(top: insetVertical * 0.5, left: insetHorizontal * 0.5, bottom: insetVertical * 0.5, right: insetHorizontal * 0.5)
	}

}
