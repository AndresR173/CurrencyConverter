//
//  CurrencyConvernterView.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 23/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import UIKit

class CurrencyConverterView: UIView {

    // MARK: - UI Elements

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("converter.title", comment: "")
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("converter.description", comment: "")
        label.textAlignment = .center

        return label
    }()

    private lazy var billsTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.layer.cornerRadius = 7
        textField.textAlignment = .center

        if #available(iOS 13.0, *) {
            textField.backgroundColor = .systemGray5
        }

        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 30)
        ])

        return textField
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(billsTextField)

        return stackView
    }()

    private lazy var barChart: BasicBarChart = {
        let barChart = BasicBarChart()
        barChart.translatesAutoresizingMaskIntoConstraints = false

        return barChart
    }()

    // MARK: - Properties

    typealias ChangeHandler = (String?) -> Void

    var textFieldHandler: ChangeHandler?

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func configureUI() {

        if #available(iOS 13.0, *) {
            backgroundColor = .systemGray6
        } else {
            backgroundColor = .white
        }

        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(barChart)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: readableContentGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            barChart.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            barChart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            barChart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            barChart.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor)
        ])
    }

    // MARK: - Helpers

    @objc private func textFieldDidChange(_ textField: UITextField) {
        textFieldHandler?(textField.text)
    }

    func updateDataEntries(_ dataEntries: [DataEntry], animated: Bool) {
        barChart.updateDataEntries(dataEntries: dataEntries, animated: animated)
    }

}
