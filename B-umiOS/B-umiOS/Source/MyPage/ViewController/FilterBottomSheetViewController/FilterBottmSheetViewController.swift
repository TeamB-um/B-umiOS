//
//  MyWritingPopUpViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/07.
//
import SnapKit
import Then
import UIKit

class FilterBottmSheetViewController: UIViewController {
    // MARK: - UIComponenets
    
    let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    let confirmButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .blue2Main
        $0.tintColor = .white
        $0.setTitle("확인", for: .normal)
        $0.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
    }
    
    lazy var categoryTagCollecitonView: UICollectionView = {
        var layout = CollectionViewLeftAlignFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(WritingTagCollectionViewCell.self, forCellWithReuseIdentifier: WritingTagCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    lazy var categoryLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "카테고리"
    }
    
    var settingPeriodView = UIView().then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
    }
    
    var datePickerView: UIDatePicker = {
        var picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko_KO")
        var components = DateComponents()
        
        components.year = 10
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        
        components.year = -10
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        
        picker.maximumDate = maxDate
        picker.minimumDate = minDate
        picker.addTarget(self, action: #selector(datePickerIsChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    lazy var startDateButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitleColor(.iconGray, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(datePickerButtonSelected(_:)), for: .touchUpInside)
        $0.isHidden = true
    }
    
    var startDateLine = UIView()
    
    var endDateLine = UIView()
    
    var startLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .green2Main
        $0.text = "시작"
        $0.isHidden = true
    }
    
    var endLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .iconGray
        $0.text = "끝"
        $0.isHidden = true
    }
    
    lazy var endDateButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitleColor(.iconGray, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(datePickerButtonSelected(_:)), for: .touchUpInside)
        $0.isHidden = true
    }
    
    lazy var setDateLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "기간 설정"
    }
    
    var dateSwitch = UISwitch().then {
        $0.isOn = false
        $0.onTintColor = .blue2Main
        $0.addTarget(self, action: #selector(didTapSwitch(_:)), for: .touchUpInside)
    }
    
    let rect = UIView().then {
        $0.backgroundColor = .paper1
        $0.cornerRound(radius: 5)
    }
    
    let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapBackgroundButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .clear
    }
    
    // MARK: - Properties
    
    var selecetedStartDatePicker: Bool = true
    let dateFormatter = DateFormatter().then {
        $0.locale = Locale(identifier: "ko_KO")
        $0.dateFormat = "yyyy.MM.dd(E)"
    }

    var components = DateComponents()
    var endMinimumDate = Date()
    var bgDelegate: viewDelegate?
    var tag: [Category] = []
    var startDate = Date()
    var endDate = Date()
    var categoryID: String = ""
    var categoryName: String = ""
    var tagSelectedIdx: Int = 0
    var parentDelegate: ChangeWritingDataDelegate?
    var delegate: ChangeWritingDataDelegate?
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setFirstDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCategoriesData()
    }
    
    // MARK: - Actions
    
    func fetchCategoriesData() {
        ActivityIndicator.shared.startLoadingAnimation()
        
        CategoryService.shared.fetchCategories { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let result = response as? NetworkResult<Any> else { return }
            
            switch result {
            case .success(let data):
                guard let result = data as? GeneralResponse<CategoriesResponse> else { return }
                self.tag = result.data?.category ?? []
                self.categoryTagCollecitonView.reloadData()
            case .requestErr, .pathErr, .serverErr, .networkFail:
                print("error")
            }
        }
    }
    
    @objc private func didTapBackgroundButton(_ sender: UIButton) {
        bgDelegate?.backgroundRemove()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func datePickerIsChanged(_ sender: UIPickerView) {
        if selecetedStartDatePicker {
            startDate = datePickerView.date
            let dateText = dateFormatter.string(from: datePickerView.date)
            startDateButton.setTitle(dateText, for: .normal)
            endMinimumDate = datePickerView.date
            
        } else {
            endDate = datePickerView.date
            let dateText = dateFormatter.string(from: datePickerView.date)
            endDateButton.setTitle(dateText, for: .normal)
        }
    }
    
    @objc private func datePickerButtonSelected(_ sender: UIButton) {
        let dateString = sender.currentTitle
        let date = dateFormatter.date(from: dateString!)
        datePickerView.date = date!
        
        if sender == startDateButton {
            selecetedStartDatePicker = true
            startDateLine.backgroundColor = .green2Main
            startLabel.textColor = .green2Main
            endDateLine.backgroundColor = .disable
            endLabel.textColor = .iconGray
            setStardMinimumDate()
        } else {
            selecetedStartDatePicker = false
            startDateLine.backgroundColor = .disable
            startLabel.textColor = .iconGray
            endDateLine.backgroundColor = .green2Main
            endLabel.textColor = .green2Main
            datePickerView.minimumDate = endMinimumDate
        }
        changeDateText(button: sender)
    }
    
    @objc private func didTapSwitch(_ sender: UISwitch) {
        if sender.isOn {
            settingPeriodView.snp.updateConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalTo(categoryLabel.snp.top).offset(-34)
                make.height.equalTo(220)
            }
            startLabel.isHidden = false
            startDateButton.isHidden = false
            endLabel.isHidden = false
            endDateButton.isHidden = false
        } else {
            settingPeriodView.snp.updateConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalTo(categoryLabel.snp.top).offset(-34)
                make.height.equalTo(0)
            }
        }
    }

    @objc private func didTapConfirmButton(_ sender: UIButton) {
//        let writtenDate = Date().ISOStringToDate(date: data.createdDate)
//        let date = Date().ISODateToString(format: "yyyy.MM.dd(E)", date: writtenDate)
//        self.dateLabel.text = date
        
        var startDate = startDate.dateToString(format: "yyyy-MM-dd", date: startDate)
        var endDate = endDate.dateToString(format: "yyyy-MM-dd", date: endDate)
        
        if !dateSwitch.isOn {
            startDate = ""
            endDate = ""
        }
        
        ActivityIndicator.shared.startLoadingAnimation()
        
        WritingService.shared.filterWritings(start_date: startDate, end_date: endDate, category_id: categoryID) { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let result = response as? NetworkResult<Any> else { return }
            switch result {
            case .success(let data):
                guard let result = data as? GeneralResponse<WritingsResponse> else { return }
                
                if let d = result.data?.writing {
                    self.delegate = self.parentDelegate
                    self.delegate?.changeWitingData(filteredDate: d)
                    self.dismiss(animated: true, completion: {
                        self.categoryTagCollecitonView.reloadData()
                        NotificationCenter.default.post(name: Notification.Name.categoryIsChanged, object: self.categoryName)
                        
                    })
                }
                
            case .requestErr(ErrorMessage.notFound):
                self.delegate = self.parentDelegate
                self.delegate?.changeWitingData(filteredDate: [])
                self.dismiss(animated: true, completion: {
                    self.categoryTagCollecitonView.reloadData()
                    NotificationCenter.default.post(name: Notification.Name.categoryIsChanged, object: self.categoryName)
                    
                })
            default:
                print("error")
            }
        }
        bgDelegate?.backgroundRemove()
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .clear
    }
    
    func setFirstDatePicker() {
        // 익스텐션 사용하는 걸로 수정할게요
        let nowDateTime = Date()
        let tmpDateFormatter = DateFormatter()
        tmpDateFormatter.dateFormat = "yyyy.MM.dd(E)"
        
        startDateLine.backgroundColor = .green2Main
        endDateLine.backgroundColor = .disable
        
        startDateButton.setTitle(dateFormatter.string(from: nowDateTime), for: .normal)
        endDateButton.setTitle(dateFormatter.string(from: nowDateTime), for: .normal)
    }
    
    func setStardMinimumDate() {
        components.year = -10
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        datePickerView.minimumDate = minDate
    }
    
    func changeDateText(button: UIButton) {
        if button == startDateButton {
            startDate = datePickerView.date
        } else {
            endDate = datePickerView.date
        }
    }
}

// MARK: - Protocols
