//
//  ActivityIndicator.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/15.
//

import Lottie
import UIKit

class ActivityIndicator {
    static let shared = ActivityIndicator()
    
    let window = UIApplication.shared.windows.first
    
    private var lottieLoading = AnimationView().then {
        $0.frame = CGRect(origin: .zero, size: CGSize(width: 80 * SizeConstants.screenRatio, height: 80 * SizeConstants.screenRatio))
        $0.animation = Animation.named("loading")
        $0.loopMode = .loop
    }
    
    func startLoadingAnimation() {
        window?.addSubview(lottieLoading)
        
        lottieLoading.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
        
        lottieLoading.play()
    }
    
    func stopLoadingAnimation() {
        lottieLoading.stop()
        lottieLoading.removeFromSuperview()
    }
}
