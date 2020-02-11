//
//  MemoryGameView.swift
//  Flip_Card_Game
//
//  Created by samet on 13.03.2019.
//  Copyright © 2019 Fundev. All rights reserved.
//

import UIKit
import SnapKit

final class MemoryGameView: UIView, Layoutable {

	lazy var collectionView: UICollectionView = {
		let view = UICollectionView(frame: frame, collectionViewLayout: MemoryGameCollectionViewLayout())
		view.backgroundColor = .clear
		view.allowsMultipleSelection = true
		view.register(MemoryGameCollectionViewCell.self, forCellWithReuseIdentifier: "MemoryGameCollectionViewCell")
		view.isScrollEnabled = false
		return view
	}()

	lazy var levelButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
		button.tintColor = .white
		button.imageView?.contentMode = .scaleToFill
		return button
	}()

	func setupViews() {
		addSubview(collectionView)

		addSubview(levelButton)
	}

	func setupLayout() {
		
		collectionView.snp.makeConstraints { $0.edges.equalToSuperview().inset(20) }

		levelButton.snp.makeConstraints { make in
			make.trailing.top.equalToSuperview().inset(25)
			make.width.height.equalTo(30)
		}

	}

}
