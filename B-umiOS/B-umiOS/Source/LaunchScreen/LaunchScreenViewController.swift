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

    // FIXME: - SERVER 수정 후 로그인 주석 해제
    func login() {
            UserDefaults.standard.set("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjEyNGEyNjNkNWVlYmQyNjU5ZDRlMGM0In0sImlhdCI6MTYyOTc5MDgyMCwiZXhwIjoxNjMwMTUwODIwfQ.YSs2VK7BCpaD51hpFo6rBYNyHsjcFRjwE9ze1Y77gcE", forKey: UserDefaults.Keys.token)
    //        print(result.data?.token ?? "NO TOKEN", "🐱 token")
            fetchUserInfo()
            Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { _ in
                let tabBar = FloatingTabBarController()
                tabBar.modalTransitionStyle = .crossDissolve
                tabBar.modalPresentationStyle = .fullScreen

                self.present(tabBar, animated: true, completion: nil)
            }
    //        UserService.shared.login { response in
    //            guard let result = response as? NetworkResult<Any> else { return }
    //
    //            switch result {
    //            case .success(let data):
    //                guard let result = data as? GeneralResponse<TokenResponse> else { return }
    //
    //            case .requestErr, .pathErr, .serverErr, .networkFail:
    //                print("에러 팝업을 띄우기")
    //            }
    //        }
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
