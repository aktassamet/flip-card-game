//
//  AlertShowing.swift
//  Flip_Card_Game
//
//  Created by samet on 11.02.2020.
//  Copyright © 2020 Fundev. All rights reserved.
//

import UIKit

protocol AlertShowing: AnyObject {

	func showAlert(title: String?, message: String?, actionTitle: String, _ actionHandler: (() -> Void)?)

}

extension AlertShowing where Self: UIViewController {

	func showAlert(title: String?, message: String?, actionTitle: String = "OK", _ actionHandler: (() -> Void)? = nil) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: actionTitle, style: .default) { _ in
			actionHandler?()
		}
		alert.addAction(action)
		present(alert, animated: true)
	}

}
