//
//  ContactViewController.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/01/31.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet private weak var contactsTableView: UITableView!

    @IBAction func addContact(_ sender: UIBarButtonItem) {
        let addContactViewController = AddContactViewController()
        addContactViewController.delegate = self
        
        present(addContactViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRandomContact(with: 10)
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
    }

    private func makeRandomContact(with count: Int) {
        for _ in 0..<count {
            let contact = Contact(name: DummyContactInfo.name.random, age: DummyContactInfo.age.random, phoneNumber: DummyContactInfo.phoneNumber.random)
            contacts.append(contact)
        }
    }
}

extension ContactViewController: UITableViewDataSource {
    
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

extension ContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        contacts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension ContactViewController: AddContactViewDelegate {
    
    func reloadTableView() {
        contactsTableView.reloadData()
    }
}
