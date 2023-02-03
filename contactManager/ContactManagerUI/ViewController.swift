//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/01/31.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        makeRandomContact(count: 1000)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.rightSideButtonTapped(_:)))
        self.navigationItem.title = "연락처"
    }

    @objc func rightSideButtonTapped(_ sender: UIBarButtonItem!) {
        let newViewController = ActionViewController()
        present(newViewController, animated: true)
    }

    private func makeRandomContact(count: Int) {
        for _ in 0..<count {
            let contact = Contact(name: ContactInfo.name.random, age: ContactInfo.age.random, phoneNumber: ContactInfo.phoneNumber.random)
            contacts.append(contact)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier = "ContactCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIndentifier)
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = configure(cell: cell, at: indexPath)
        return cell
    }
    
    private func configure(cell: UITableViewCell, at indexPath: IndexPath) -> UIListContentConfiguration {
        var content = cell.defaultContentConfiguration()
        content.text = "\(contacts[indexPath.row].name)(\(contacts[indexPath.row].age))"
        content.secondaryText = "\(contacts[indexPath.row].phoneNumber)"
        content.textProperties.font = .systemFont(ofSize: 16)
        content.secondaryTextProperties.font = .systemFont(ofSize: 16)
        return content
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
