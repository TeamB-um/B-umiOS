//
//  LaunchScreenViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Lottie
import UIKit

class LaunchScreenViewController: UIViewController {
    // MARK: - UIComponenets

    private let splashView = AnimationView().then {
        $0.animation = Animation.named("bium_splash")
        $0.loopMode = .loop
    }

    // MARK: - Properties

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
        presentHomeView()
    }

    // MARK: - Actions

    // MARK: - Methods

    func setConstraints() {
        view.addSubview(splashView)

        splashView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func presentHomeView() {
        splashView.play()

        // FIXME: - (Timer 제거하고) 로그인 절차 추가해야함

        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            let tabBar = FloatingTabBarController()
            tabBar.modalTransitionStyle = .crossDissolve
            tabBar.modalPresentationStyle = .fullScreen

            self.present(tabBar, animated: true, completion: nil)
        }
    }

    // MARK: - Protocols
}
