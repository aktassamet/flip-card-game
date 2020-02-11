//
//  Layouting.swift
//  Flip_Card_Game
//
//  Created by samet on 11.02.2020.
//  Copyright © 2020 Fundev. All rights reserved.
//

import UIKit

/// Conform to `Layouting` in `UIViewController` that layouts a `Layoutable` `UIView`
protocol Layouting: AnyObject {

	/// `Layoutable` view type
	associatedtype ViewType: UIView & Layoutable

	/// view as a `Layoutable` view type.
	var layoutableView: ViewType { get }

}

extension Layouting where Self: UIViewController {

	/// view as a `Layoutable` view type.
	var layoutableView: ViewType {
		guard let aView = view as? ViewType else {
			fatalError("view property has not been initialized yet, or not initialized as \(ViewType.self).")
		}
		return aView
	}

}
