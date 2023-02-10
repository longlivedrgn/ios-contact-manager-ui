//
//  ContactViewController.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/01/31.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet private weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isFiltering: Bool = false
    var filterredContacts: [Contact] = []
    
    @IBAction func addContact(_ sender: UIBarButtonItem) {
        let addContactViewController = AddContactViewController()
        addContactViewController.delegate = self
        
        present(addContactViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRandomContact(with: 1000)
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        searchBar.delegate = self
        // searchBar의 cancel 버튼을 보여줄 지 안보여줄 지 정하기
        searchBar.showsCancelButton = false
        
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
        return isFiltering ? filterredContacts.count : contacts.count
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
        
        if isFiltering {
            content.text = "\(filterredContacts[indexPath.row].name)(\(filterredContacts[indexPath.row].age))"
            content.secondaryText = "\(filterredContacts[indexPath.row].phoneNumber)"
            content.textProperties.font = .systemFont(ofSize: 16)
            content.secondaryTextProperties.font = .systemFont(ofSize: 16)
        } else {
            content.text = "\(contacts[indexPath.row].name)(\(contacts[indexPath.row].age))"
            content.secondaryText = "\(contacts[indexPath.row].phoneNumber)"
            content.textProperties.font = .systemFont(ofSize: 16)
            content.secondaryTextProperties.font = .systemFont(ofSize: 16)
        }
        
        return content
    }
}

extension ContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if isFiltering {
            guard let contactIndex = contacts.firstIndex(of: filterredContacts[indexPath.row]) else { return }
            filterredContacts.remove(at: indexPath.row)
            contacts.remove(at: contactIndex)
        } else {
            contacts.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension ContactViewController: AddContactViewDelegate {
    
    func reloadTableView() {
        contactsTableView.reloadData()
    }
}

extension ContactViewController: UISearchBarDelegate {
    
    // 서치바에서 검색을 시작할 때 호출된다.
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isFiltering = true
        searchBar.showsCancelButton = true
    }
    
    // 서치바의 값이 변경될 때마다 호출이된다.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        if text == "" {
            filterredContacts = contacts
        } else {
            filterredContacts = contacts.filter { Contact in
                Contact.name.localizedCaseInsensitiveContains(text)
            }
        }
        contactsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // 서치바에서 취소 버튼을 눌렀을 때 호출된다.
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isFiltering = false
        contactsTableView.reloadData()
    }
}
