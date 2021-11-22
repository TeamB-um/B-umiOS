//
//  OpenSourceViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/11/02.
//

import UIKit

struct Library {
    let name: String
    let link: String
    let license: String
}

class OpenSourceViewController: UIViewController {
    // MARK: - UIComponenets
    
    lazy var tableView = UITableView().then {
        $0.register(OpenSourceTableViewCell.self, forCellReuseIdentifier: OpenSourceTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        $0.allowsMultipleSelection = false
    }
    
    lazy var navigationView = CustomNavigationBar(title: "오픈소스 라이센스") {
        [weak self] in
        self?.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Properties
    
    let libraries: [Library] = [Library(name: "Alamofire", link: "https://github.com/Alamofire/Alamofire/blob/master/LICENSE", license: "MIT License\nCopyright (c) 2014-2021 Alamofire Software Foundation (http://alamofire.org/)"), Library(name: "Then", link: "https://github.com/devxoul/Then/blob/master/LICENSE", license: "MIT License\nCopyright (c) 2015 Suyeol Jeon (xoul.kr)"), Library(name: "SnapKit", link: "https://github.com/SnapKit/SnapKit/blob/develop/LICENSE", license: "MIT License\nCopyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit"), Library(name: "lottie-ios", link: "https://github.com/airbnb/lottie-ios/blob/master/LICENSE", license: "Apache License 2.0\nCopyright 2018 Airbnb, Inc."), Library(name: "MultiProgressView", link: "https://github.com/mac-gallagher/MultiProgressView/blob/master/LICENSE", license: "MIT License\nCopyright (c) 2018 Mac Gallagher"), Library(name: "firebase-ios-sdk", link: "https://github.com/firebase/firebase-ios-sdk/blob/master/LICENSE", license: "Apache License 2.0\nCopyright 2020 Google LLC")]
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func setConstraints() {
        view.addSubviews([navigationView, tableView])
        
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Protocols

extension OpenSourceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        libraries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OpenSourceTableViewCell.identifier) as? OpenSourceTableViewCell else { return UITableViewCell() }
        
        cell.setCell(libarary: libraries[indexPath.row])
        return cell
    }
}

extension OpenSourceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: libraries[indexPath.row].link) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
