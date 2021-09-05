//
//  MyWritingViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyWritingViewController: UIViewController {
    // MARK: - UIComponenets
    
    lazy var myWritingCollectionView: UICollectionView = {
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
        $0.image = UIImage.group192
        $0.isHidden = true
    }
    
    var errorLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .textGray
        $0.text = "error"
        $0.isHidden = true
    }
    
    let backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.frame = CGRect(origin: .zero, size: CGSize(width: SizeConstants.screenWidth, height: SizeConstants.screenHeight))
    }
    
    // MARK: - Properties
    
    var deleteButtonIsSelected: Bool = false
    var myWritingParentViewcontroller: UIViewController?
    
    //전체글, 나중에 삭제
    var totalMyWritngs: [Writing] = [] {
        didSet {
            if totalMyWritngs.count == 0 {
                errorView.isHidden = false
                errorLabel.isHidden = false
                errorLabel.text = "아직 글을 작성하지 않았어요!"
            } else {
                errorView.isHidden = true
                errorLabel.isHidden = true
            }
        }
    }
    //보여질 글 즉시 삭제
    var myWriting: [Writing] = []
    var page = 1
    var totalWritingCount = 0
    var pagedWritingCount = 0
    var removeData: [Int] = []
    var deleteData: [String] = []
    var categoryID: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var header = ButtonSectionView()
    var fetchingMore = false
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetFilter()
        fetchWriting(page: 1)
        print("어렵다.어려워")
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        deleteMyWriting()
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deleteMyWriting()
        
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func resetFilter() {
        NotificationCenter.default.post(name: Notification.Name.categoryIsChanged, object: "")
        
        categoryID = ""
        startDate = ""
        endDate = ""
        myWriting = []
        totalMyWritngs = []
        removeData = []
        fetchingMore = false
        page = 1
        totalWritingCount = 0
        myWritingCollectionView.reloadData()
        
        if let button = self.view.viewWithTag(2) as? RoundingButton {
            button.setupRoundingButton(title: "삭제", image:"btnRemove")
            button.isSelected = false
        }
        
        if deleteButtonIsSelected {
            NotificationCenter.default.post(name: NSNotification.Name.deleteButtonIsSelected, object: header.deleteButton.isSelected)
            self.view.viewWithTag(1)?.isHidden = true
        }
    }
    
    func fetchWriting(page: Int) {
        if page == 1, !deleteData.isEmpty {
            deleteMyWriting()
            print("삭제되나?")
        }
        
        print("fetchWritingfetchWritingfetchWritingfetchWriting",page)
        ActivityIndicator.shared.startLoadingAnimation()
        WritingService.shared.fetchWriting(page: "\(page)", start_date: startDate, end_date: endDate, category_id: categoryID) { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let result = response as? NetworkResult<Any> else { return }
            switch result {
            case .success(let data):
                guard let writingData = data as? GeneralResponse<WritingsResponse> else { return }
                self.errorView.isHidden = true
                self.errorLabel.isHidden = true
                if let d = writingData.data {
                    self.totalWritingCount = d.count ?? 0
                    for i in 0..<d.writing.count {
                        self.myWriting.append(d.writing[i])
                        self.totalMyWritngs.append(d.writing[i])
                    }
                    self.fetchingMore = true
                    self.myWritingCollectionView.reloadData()
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
    
    func deleteMyWriting() {
        if !deleteData.isEmpty {
        var query = ""
        for (index, item) in deleteData.enumerated() {
            if index == 0 {
                query = item
            }
            else {
                query = "\(query),\(item)"
            }
        }
        WritingService.shared.deleteWriting(writings: query) { response in
            
            guard let result = response as? NetworkResult<Any> else { return }
            switch result {
            case .success:
                print("success")
                self.deleteData = []
                self.myWritingCollectionView.reloadData()
                //                case .success:
                //                    self.deleteDelegate = self.parentDelegate
                //                    self.deleteDelegate?.sendWritings()
//
//                guard let writings = response as? GeneralResponse<WritingsResponse> else { return }
//                self.deleteDelegate = self.parentDelegate
//                self.deleteDelegate?.sendWritings(writings.data?.writing ?? [])
            default:
                print("error")
            }
        }
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
        popUpVC.startDate = startDate
        popUpVC.endDate = endDate
        popUpVC.categoryID = categoryID
        
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.modalTransitionStyle = .crossDissolve
        popUpVC.parentDelegate = self
        present(popUpVC, animated: true, completion: nil)
    }
    
    @objc func didTapCategoryButton(_ sender: UIButton) {
        let popUpVC = FilterBottmSheetViewController()
        
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.parentDelegate = self
        popUpVC.bgDelegate = self
        
        let window = UIApplication.shared.windows.first
        window?.addSubview(backgroundView)
        
        present(popUpVC, animated: true, completion: nil)
    }
    
    @objc func deleteButtonClicked(noti: NSNotification) {
        if let isClicked = noti.object as? Bool {
            deleteButtonIsSelected.toggle()
            myWritingCollectionView.reloadData()
        }
    }
}

// MARK: - Protocol

protocol ChangeWritingDataDelegate {
    func changeWitingData(filteredDate: [Writing], count: Int?)
    func remainFilterData(filteredCategoryID: String, filteredStartDate: String, filteredEndDate: String)
}

protocol DeleteWritingsDelegate {
    func deleteWriting()
}

protocol viewDelegate {
    func backgroundRemove()
}
