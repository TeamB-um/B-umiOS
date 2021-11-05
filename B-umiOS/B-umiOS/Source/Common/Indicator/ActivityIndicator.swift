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
        $0.frame = CGRect(origin: .zero, size: CGSize(width: 80 * SizeConstants.screenWidthRatio, height: 80 * SizeConstants.screenWidthRatio))
        $0.animation = Animation.named("loading")
        $0.loopMode = .loop
    }
    
    func startLoadingAnimation() {
        window?.addSubview(lottieLoading)
        window?.isUserInteractionEnabled = false
        
        lottieLoading.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
        
        lottieLoading.play()
    }
    
    func stopLoadingAnimation() {
        window?.isUserInteractionEnabled = true
        
        lottieLoading.stop()
        lottieLoading.removeFromSuperview()
    }
}
