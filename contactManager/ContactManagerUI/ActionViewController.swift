//
//  ActionViewController.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/02/01.
//

import UIKit

class ActionViewController: UIViewController {
    
    // MARK: - Properties
    
    var  navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "새 연락처")
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = saveItem
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        return label
    }()
    
    var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "나이"
        return label
    }()
    
    var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "연락처"
        return label
    }()
    
    var nameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    var ageTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    var ageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    var phoneNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addsubviews()
        configureLayout()
    }

    // MARK: - Functions
    
    private func addsubviews() {
        view.addSubview(navigationBar)
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(ageStackView)
        stackView.addArrangedSubview(phoneNumberStackView)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)

        ageStackView.addArrangedSubview(ageLabel)
        ageStackView.addArrangedSubview(ageTextField)
        
        phoneNumberStackView.addArrangedSubview(phoneNumberLabel)
        phoneNumberStackView.addArrangedSubview(phoneNumberTextField)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            navigationBar.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 20),
        ])
    }
    

}
