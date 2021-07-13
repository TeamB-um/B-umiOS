//
//  LaunchScreenViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Alamofire
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
        login()
    }

    override func viewWillAppear(_ animated: Bool) {
        splashView.play()
    }

    // MARK: - Actions

    // MARK: - Methods

    func setConstraints() {
        view.addSubview(splashView)

        splashView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func login() {
        LoginService.shared.login { result in
            if result {
                Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { _ in
                    let tabBar = FloatingTabBarController()
                    tabBar.modalTransitionStyle = .crossDissolve
                    tabBar.modalPresentationStyle = .fullScreen

                    self.present(tabBar, animated: true, completion: nil)
                }
            } else {
                print("네트워크 에러 팝업을 띄우기")
            }
        }
    }

    // MARK: - Protocols
}
