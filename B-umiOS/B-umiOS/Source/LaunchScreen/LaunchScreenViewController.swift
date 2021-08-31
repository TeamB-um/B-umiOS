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
         UserService.shared.login { response in
             guard let result = response as? NetworkResult<Any> else { return }

             switch result {
             case .success(let data):
                 guard let result = data as? GeneralResponse<TokenResponse> else { return }
                 UserDefaults.standard.set(result.data?.token, forKey: UserDefaults.Keys.token)
                 print(result.data?.token ?? "NO TOKEN", "🐱 token")
                self.fetchUserInfo()
                 Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { _ in
                     let tabBar = FloatingTabBarController()
                     tabBar.modalTransitionStyle = .crossDissolve
                     tabBar.modalPresentationStyle = .fullScreen

                     self.present(tabBar, animated: true, completion: nil)
                 }
             case .requestErr, .pathErr, .serverErr, .networkFail:
                 print("에러 팝업을 띄우기")
             }
         }
    }

    func fetchUserInfo() {
        UserService.shared.fetchUserInfo { response in
            guard let result = response as? NetworkResult<Any> else { return }

            switch result {
            case .success(let data):
                if let userInfoResponse = data as? GeneralResponse<UserResponse>,
                   let user = userInfoResponse.data?.user
                {
                    UserDefaults.standard.set(user.isPush, forKey: UserDefaults.Keys.isPush)
                    UserDefaults.standard.set(user.deletePeriod, forKey: UserDefaults.Keys.deletePeriod)
                }
            case .requestErr, .pathErr, .serverErr, .networkFail:
                break
            }
        }
    }

    // MARK: - Protocols
}
