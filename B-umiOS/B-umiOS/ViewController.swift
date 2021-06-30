//
//  ViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/06/29.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func didTapHomeLabel(_ sender: Any) {
        let homeViewController = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "HomeViewController")

        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}
