//
//  GameView.swift
//  Flip_Card_Game
//
//  Created by samet on 13.03.2019.
//  Copyright © 2019 Fundev. All rights reserved.
//

import UIKit
import SnapKit

final class GameView: UIView {

	lazy var collectionView: UICollectionView = {
		let view = UICollectionView(frame: frame, collectionViewLayout: MemoryGameCollectionViewLayout())
		view.backgroundColor = .clear
		view.allowsMultipleSelection = true
		view.register(MemoryGameCollectionViewCell.self, forCellWithReuseIdentifier: "MemoryGameCollectionViewCell")
		view.isScrollEnabled = false
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViews()
		setupLayout()
	}

	func setupViews() {
		addSubview(collectionView)
	}

	func setupLayout() {
		
		collectionView.snp.makeConstraints { $0.edges.equalToSuperview().inset(20) }

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
