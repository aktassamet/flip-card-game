//
//  MemoryGameCollectionViewCell.swift
//  Flip_Card_Game
//
//  Created by samet on 13.03.2019.
//  Copyright © 2019 Fundev. All rights reserved.
//


import UIKit

final class MemoryGameCollectionViewCell: UICollectionViewCell {

	var face: Card.Face = .back
	var isLocked: Bool = false

	static var duration: TimeInterval = 0.5

	private lazy var frontImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = #imageLiteral(resourceName: "iconMemoryGameCloseCard")
		return imageView
	}()

	private lazy var backImageView: UIImageView = {
		return UIImageView()
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViews()
		setupLayout()
	}

	func setupViews() {
		backImageView.isHidden = true
		addSubview(backImageView)

		addSubview(frontImageView)
	}

	func setupLayout() {
		backImageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(5) }
		frontImageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(5) }
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


}

// MARK: - Configure
extension MemoryGameCollectionViewCell {

	func configure(for card: Card) {
		backImageView.image = card.image
	}

}

// MARK: - Helpers
extension MemoryGameCollectionViewCell {

	func flip() {
		var direction: UIView.AnimationOptions
		var fromView: UIView
		var toView: UIView

		switch face {
		case .front:
			face = .back
			direction = .transitionFlipFromLeft
			fromView = frontImageView
			toView = backImageView
		case .back:
			face = .front
			direction = .transitionFlipFromRight
			fromView = backImageView
			toView = frontImageView
		}

		let options: UIView.AnimationOptions = [direction, .showHideTransitionViews]

		UIView.transition(with: fromView, duration: MemoryGameCollectionViewCell.duration, options: options, animations: nil)

		UIView.transition(with: toView, duration: MemoryGameCollectionViewCell.duration, options: options, animations: {
			fromView.isHidden = false
		})

		DispatchQueue.main.asyncAfter(deadline: .now() + MemoryGameCollectionViewCell.duration / 2) {
			toView.isHidden = true
		}
	}
}
