//
//  SimpleTableViewCell.swift
//  Triet Le GoodNotes Challenge
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {

    // MARK: - Dependencies
    var titleString: String? {
        didSet {
            titleLabel.text = titleString
        }
    }

    var timestamp: TimeInterval? {
        didSet {
            timestampLabel.text = "\(timestamp!.dateDisplayString)"
        }
    }

    // MARK: - Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.text = nil
        return label
    }()

    private lazy var timestampLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.text = nil
        return label
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.backgroundColor = .clear

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(timestampLabel)

        return stackView
    }()

    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: - Private methods
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        addSubview(mainStackView)

        setConstraints()
    }

    private func setConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

}
