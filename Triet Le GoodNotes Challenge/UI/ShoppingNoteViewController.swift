//
//  ShoppingNoteViewController.swift
//  Triet Le GoodNotes Challenge
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

class ShoppingNoteViewController: UIViewController {

    // MARK: - Private properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)

        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = true

        tableView.register(SimpleTableViewCell.self, forCellReuseIdentifier: "SimpleTableViewCell")

        return tableView
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()

        button.setTitle("Add New Item", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)

        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()

    private var shoppingNoteSet = ShoppingNoteSet<String>()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(addButton)

        setConstraints()
    }

    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20)
        ])
    }

    @objc private func addTapped() {
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Item Name"
        }

        alert.addTextField { textField in
            textField.placeholder = "Item Timestamp"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let textFields = alert.textFields else { return }
            let firstTextField = textFields[0] as UITextField
            let secondTextField = textFields[1] as UITextField
            self?.addNewItem(itemName: firstTextField.text, timestamp: secondTextField.text)
        }

        alert.addAction(addAction)
        alert.addAction(cancelAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }

    private func addNewItem(itemName: String?, timestamp: String?) {
        guard let itemName = itemName, let timestamp = timestamp, let timestampInterval = TimeInterval(timestamp) else { return }
        shoppingNoteSet.add(ShoppingNote(itemName, timestampInterval))
        tableView.reloadDataAnimated()
    }

    private func editItem(at indexPath: IndexPath) {
        let currentItem = shoppingNoteSet.items[indexPath.row]

        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.text = currentItem.item
            textField.isUserInteractionEnabled = false
        }

        alert.addTextField { textField in
            textField.text = "\(currentItem.timestamp)"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textFields = alert.textFields else { return }
            let firstTextField = textFields[0] as UITextField
            let secondTextField = textFields[1] as UITextField
            self?.addNewItem(itemName: firstTextField.text, timestamp: secondTextField.text)
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }

    private func removeItem(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Do you really want to remove \(shoppingNoteSet.items[indexPath.row].item)", message: nil, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "YES", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.shoppingNoteSet.remove(self.shoppingNoteSet.items[indexPath.row])
            self.tableView.reloadDataAnimated()
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension ShoppingNoteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingNoteSet.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let simpleCell = tableView.dequeueReusableCell(withIdentifier: "SimpleTableViewCell", for: indexPath) as! SimpleTableViewCell

        simpleCell.titleString = shoppingNoteSet.items[indexPath.row].item
        simpleCell.timestamp = shoppingNoteSet.items[indexPath.row].timestamp

        return simpleCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let removeAction = UIContextualAction(style: .normal, title: "Remove") { [weak self] (_, _, _) in
            self?.removeItem(at: indexPath)
        }
        removeAction.backgroundColor = .red

        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, _) in
            self?.editItem(at: indexPath)
        }
        editAction.backgroundColor = .blue

        return UISwipeActionsConfiguration(actions: [removeAction, editAction])
    }
}
