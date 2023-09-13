//
//  TouchDownPanGestureRecognizer.swift
//  TextStrock
//
//  Created by PosterMaker on 9/12/23.
//

import Foundation


class TouchDownPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        state = .began
    }
}
