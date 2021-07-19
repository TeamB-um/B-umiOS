//
//  ThrowTrashViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/08.
//

import UIKit

enum TrashType: String {
    case trash = "삭제 휴지통"
    case separate = "분리수거함"
}

class ThrowTrashViewController: UIViewController {
    // MARK: - UIComponenets

    let navigationView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var navigationLabel = UILabel().then {
        $0.text = self.trashType.rawValue
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = UIColor.white
    }
    
    lazy var backButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
        self.navigationController?.popViewController(animated: true)
    })).then {
        $0.setImage(UIImage.btnBack.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
    }
    
    lazy var backgroudImage = UIImageView().then {
        $0.image = UIImage(named: "img_\(self.trashType)")
    }
    
    let explanationView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 13, offset: CGSize(width: 1, height: 4), opacity: 0.1, color: UIColor(red: 45 / 255, green: 45 / 255, blue: 45 / 255, alpha: 1))
    }
    
    let explanationImage = UIImageView().then {
        $0.image = UIImage.toastPaper1
    }
    
    lazy var explanationLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .iconGray
        let attributedStr = NSMutableAttributedString(string: explainString)

        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue3, range: (explainString as NSString).range(of: self.trashType.rawValue))

        $0.attributedText = attributedStr
    }
    
    let guideLabel = UILabel().then {
        $0.text = "쓰레기통으로 넣어보세요!"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    lazy var trash = UIImageView().then {
        $0.image = UIImage.imgWritingPaper
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
    }
    
    let trashBin = UIView()

    // MARK: - Properties
    
    private var trashType: TrashType
    private var writing: WritingRequest
    private lazy var explainString = "작성된 글은 \(trashType.rawValue)으로 이동합니다."
    
    // MARK: - Initializer
    
    init(trashType: TrashType, writingRequest: WritingRequest) {
        self.trashType = trashType
        self.writing = writingRequest
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    // MARK: - Actions

    @objc
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: view)
            trash.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            guideLabel.alpha = 1
            
            let position = gesture.location(in: view)
            if position.x > trashBin.frame.midX, position.x < trashBin.frame.maxX, position.y > trashBin.frame.minY, position.y < trashBin.frame.maxY {
                throwAwayTrash()
                
                ActivityIndicator.shared.startLoadingAnimation()
                WritingService.shared.createWriting(writing: writing) { result in
                    ActivityIndicator.shared.stopLoadingAnimation()
                    if result {
                        self.showToast()
                    } else {
                        /// 네트워크 실패 토스트 띄우기
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                resetTrash()
            }
        case .began:
            guideLabel.alpha = 0
        case .cancelled, .possible, .failed: break
        @unknown default:
            break
        }
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func resetTrash() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .curveEaseIn) {
            self.trash.transform = .identity
        }
    }
    
    func throwAwayTrash() {
        guideLabel.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.trash.alpha = 0
        }
    }
    
    func showToast() {
        let msg = trashType == .trash ? "삭제되었습니다" : "분리수거 되었습니다"
        let toast = CompletionMessage(image: "img_\(trashType)_toast", message: msg)
        toast.tag = 1000
        
        tabBarController?.view.addSubview(toast)
        toast.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        /// 진동
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            toast.alpha = 0
            toast.removeFromSuperview()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: - Protocols
}
