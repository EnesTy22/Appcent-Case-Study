//
//  ProgressIcon.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 13.05.2023.
//

import Foundation
import Lottie
import UIKit

final class Loader{
    static let shared = Loader()
    var animationView : LottieAnimationView?

    func open(on view: UIView) {
        animationView = .init(name: "Play")
        animationView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        animationView?.center = view.center
        animationView?.loopMode = .loop
        view.addSubview(animationView!)
        animationView?.play()
    }
    func close() {
            animationView?.stop()
            animationView?.removeFromSuperview()
            animationView = nil
    }
}
