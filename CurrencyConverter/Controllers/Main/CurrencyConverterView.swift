//
//  CurrencyConvernterView.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 23/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import UIKit
import IntentsUI

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

    private lazy var ratesSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: Rate.availableRates)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedControlIndexDidChange), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0

        return segmentedControl
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
        textField.layer.borderWidth = 0.5
        textField.returnKeyType = .done

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

    private lazy var barChart: BeautifulBarChart = {
        let barChart = BeautifulBarChart()
        barChart.translatesAutoresizingMaskIntoConstraints = false

        return barChart
    }()

    private lazy var convertButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Convert", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 7

        button.addTarget(self, action: #selector(convertRate), for: .touchUpInside)

        return button
    }()

    // MARK: - Properties

    typealias ChangeHandler = (String?) -> Void
    typealias IndexChangeHandler = (Int) -> Void

    var textFieldHandler: ChangeHandler?
    var indexChangeHandler: IndexChangeHandler?

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
        addSubview(ratesSegmentedControl)
        addSubview(convertButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: readableContentGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            ratesSegmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            ratesSegmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),

            convertButton.topAnchor.constraint(equalTo: ratesSegmentedControl.bottomAnchor, constant: 8),
            convertButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            convertButton.widthAnchor.constraint(equalToConstant: 100),

            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            barChart.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            barChart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            barChart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            barChart.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor)
        ])
    }

    // MARK: - Helpers

    @objc private func convertRate() {
        textFieldHandler?(billsTextField.text)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {

    }

    func updateDataEntries(_ dataEntries: [DataEntry], animated: Bool) {
        barChart.updateDataEntries(dataEntries: dataEntries, animated: animated)
    }

    @objc private func segmentedControlIndexDidChange() {
        indexChangeHandler?(ratesSegmentedControl.selectedSegmentIndex)
    }

}
