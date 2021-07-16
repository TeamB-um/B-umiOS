//
//  MyWritingViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

protocol ChangeWritingDataDelegate {
    func changeWitingData(filteredDate: [Writing])
}

class MyWritingViewController: UIViewController {
    // MARK: - UIComponenets
    
    private lazy var myWritingCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .background
        
        collectionView.register(MyWritingCollectionViewCell.self, forCellWithReuseIdentifier: MyWritingCollectionViewCell.identifier)
        
        collectionView.register(ButtonSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ButtonSectionView.identifier)
        collectionView.allowsMultipleSelection = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    var errorView = UIImageView().then {
        $0.image = UIImage(named: "group192")
        $0.isHidden = true
    }
    
    var errorLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .textGray
        $0.text = "dlkslfhiwalgnlkwrg"
        $0.isHidden = true
    }

    // MARK: - Properties

    var deleteButtonIsSelected: Bool = false
    var myWritingParentViewcontroller: UIViewController?
    var myWriting: [Writing] = []
    var removeData: [Int] = []
    var headerView: UICollectionReusableView = ButtonSectionView()
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fatchWriting()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func fatchWriting() {
        WritingService.shared.fatchWriting { response in
            guard let r = response as? NetworkResult<Any> else { return }
            switch r {
            case .success(let data):
                guard let wiritingData = data as? GeneralResponse<WritingsResponse> else { return }

                if let d = wiritingData.data {
                    self.myWriting = d.writing
                    self.myWritingCollectionView.reloadData()
                } else {
                    print("success if let error")
                }
                
            case .requestErr(ErrorMessage.notFound):
                print("404 not found")
                self.errorView.isHidden = false
                self.errorLabel.isHidden = false
                self.errorLabel.text = "아직 글을 작성하지 않았어요!"
            default:
                print("default error")
                self.errorView.isHidden = false
                self.errorLabel.isHidden = false
                self.errorLabel.text = "글을 찾지 못했어요!"
            }
        }
    }
    
    func setConstraint() {
        view.addSubviews([myWritingCollectionView, errorView, errorLabel])
        myWritingCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(243 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(errorView.snp.bottom).inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(deleteButtonClicked), name: NSNotification.Name.deleteButtonIsSelected, object: nil)
    }
    
    @objc func didTapConfirmButton(_ sender: UIButton) {
        let popUpVC = DeletePopUpViewController(kind: .writing)
        var deleteID: [String] = []
        
        for index in removeData {
            deleteID.append(myWriting[index].id)
        }
        popUpVC.deleteData = deleteID
        popUpVC.categoryID = ""
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.parentDelegate = self
        present(popUpVC, animated: true, completion: nil)
    }
    
    @objc func didTapCategoryButton(_ sender: UIButton) {
        let popUpVC = FilterBottmSheetViewController()
        
        popUpVC.modalPresentationStyle = .overFullScreen
//        popUpVC.categoryID = ""
        popUpVC.parentDelegate = self
        present(popUpVC, animated: true, completion: nil)
    }
    
    @objc func deleteButtonClicked(noti: NSNotification) {
        if let isClicked = noti.object as? Bool {
            deleteButtonIsSelected.toggle()
            myWritingCollectionView.reloadData()
        }
    }
    
    // MARK: - Protocols
}

// MARK: - Extension

extension MyWritingViewController: ChangeWritingDataDelegate {
    func changeWitingData(filteredDate: [Writing]) {
        myWriting = filteredDate

        myWritingCollectionView.reloadData()
    }
}

/// 삭제한 후 데이터 변경
extension MyWritingViewController: DeleteDelegate {
    func sendWritings(_ newWritings: [Writing]) {
        removeData = []
        myWriting = newWritings
        NotificationCenter.default.post(name: Notification.Name.confirmButtonIsUnactive, object: nil)
        myWritingCollectionView.reloadData()
    }
}

extension MyWritingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myWriting.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWritingCollectionViewCell.identifier, for: indexPath) as? MyWritingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setShadow(radius: 20, offset: CGSize(width: 0, height: 4), opacity: 0.03)
        cell.setWritingData(data: myWriting, index: indexPath.row)
        
        if deleteButtonIsSelected {
            cell.emptyCheckButton.isHidden = false
        } else {
            cell.emptyCheckButton.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ButtonSectionView.identifier, for: indexPath) as? ButtonSectionView else { return UICollectionReusableView() }
        
        headerView.confirmButtton.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
        headerView.categoryButtton.addTarget(self, action: #selector(didTapCategoryButton(_:)), for: .touchUpInside)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !deleteButtonIsSelected {
            let popUpVC = MyWritingPopUpViewController(writing: myWriting[indexPath.row])
            popUpVC.modalTransitionStyle = .crossDissolve
            popUpVC.modalPresentationStyle = .overCurrentContext
            if let parentVC = view.superview?.parentViewController {
                parentVC.present(popUpVC, animated: true, completion: nil)
            } else {
                print("error")
            }
        } else {
            removeData.append(indexPath.row)
            if removeData.count >= 1 {
                NotificationCenter.default.post(name: Notification.Name.confirmButtonIsActive, object: nil)
            }
        }
    }
}

extension MyWritingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = (SizeConstants.screenWidth - 47) / 2
        let cellSize = CGSize(width: sideLength, height: sideLength)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 210, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: SizeConstants.screenWidth, height: 72 * SizeConstants.screenRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cellCount = collectionView.indexPathsForSelectedItems?.count
        
        if deleteButtonIsSelected {
            guard let elementIndex = removeData.firstIndex(of: indexPath.row) else { return }
            removeData.remove(at: elementIndex)
            
            if cellCount == 0 {
                NotificationCenter.default.post(name: Notification.Name.confirmButtonIsUnactive, object: nil)
            }
        }
    }
}
