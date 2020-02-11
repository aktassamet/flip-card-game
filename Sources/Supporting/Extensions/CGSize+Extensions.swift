//
//  CGSize+Extensions.swift
//  Flip_Card_Game
//
//  Created by samet on 11.02.2020.
//  Copyright © 2020 Fundev. All rights reserved.
//

import CoreGraphics

extension CGSize {

	/// Returns width or height, whichever is the bigger value.
	var maxDimension: CGFloat {
		return max(width, height)
	}

	/// Returns width or height, whichever is the smaller value.
	var minDimension: CGFloat {
		return min(width, height)
	}

}
