//
//  AddProductView.swift
//  ToTheStore
//
//  Created by Василий on 08.01.2023.
//

import UIKit
import SnapKit

protocol AddProduct: AnyObject {
    func addProduct(product: ProductModel)
}

protocol Closable: AnyObject {
    func close()
}

final class AddProductView: BaseView {
    
    // MARK: - Nested model
    
    private let numbers = [Int](0...1000)
    private let typeModel = ["-", "шт", "гр", "кг", "л", "уп"]
    
    // MARK: - Properties
    
    weak var addProduct: AddProduct?
    weak var closable: Closable?
    
    private let separatorView = UIView(Colors.customGray)
    
    private (set) lazy var productAddedButton = UIBarButtonItem(title: Constant.done,
                                             style: .plain,
                                             target: self,
                                             action: #selector(addProductAction(_:)))
    
    private (set) lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private (set) lazy var amountTextField: TextFieldWithPadding = {
        let amountTextField = TextFieldWithPadding()
        amountTextField.placeholder = Constant.amount
        amountTextField.backgroundColor = .white
        amountTextField.layer.cornerRadius = 6
        return amountTextField
    }()
    
    private (set) lazy var productTextField: TextFieldWithPadding = {
        let productTextField = TextFieldWithPadding()
        productTextField.placeholder = Constant.product
        productTextField.backgroundColor = .white
        productTextField.layer.cornerRadius = 6
        productTextField.addTarget(self, action: #selector(productChangedAction(_:)), for: .editingChanged)
        return productTextField
    }()
    
    // MARK: - Action
    
    @objc
    private func addProductAction(_ sender: UIBarButtonItem) {
        if productAddedButton.title == Constant.done && productTextField.text == "" {
            closable?.close()
        } else {
            if let product = productTextField.text,
               let amount = amountTextField.text {
                let productModel = ProductModel(product: product,
                                                amount: amount)
                addProduct?.addProduct(product: productModel)
                
                productAddedButton.title = Constant.done
                [productTextField, amountTextField].forEach { $0.text = nil }
            }
        }
    }
    
    @objc
    private func amountAddedAction(_ sender: UIPickerView) {
        productTextField.becomeFirstResponder()
    }

    @objc
    private func productChangedAction(_ sender: UITextField) {
        if let currentText = sender.text {
            currentText.isEmpty ? (productAddedButton.title = Constant.done) : (productAddedButton.title = Constant.add)
        }
    }
    
    // MARK: - Instance methods
    
    override func setup() {
        super.setup()
        setupToolBar()
        setupPickerView()
        
        layer.cornerRadius = 10
        productTextField.becomeFirstResponder()
        addSubviews([separatorView, amountTextField, productTextField])
        
        productTextField.snp.makeConstraints { maker in
            maker.top.equalTo(self.snp.top).offset(10)
            maker.left.equalTo(self.snp.left).offset(10)
            maker.right.equalTo(self.snp.right)
            maker.height.equalTo(35)
        }
        
        separatorView.snp.makeConstraints { maker in
            maker.top.equalTo(productTextField.snp.bottom).offset(5)
            maker.left.equalTo(self.snp.left).offset(20)
            maker.right.equalTo(self.snp.right).inset(20)
            maker.height.equalTo(1)
        }
        
        amountTextField.snp.makeConstraints { maker in
            maker.top.equalTo(separatorView.snp.bottom).offset(5)
            maker.height.equalTo(35)
            maker.left.equalTo(self.snp.left).offset(10)
            maker.right.equalTo(self.snp.right)
            maker.bottom.equalTo(self.snp.bottom).inset(10)
        }
    }
}

extension AddProductView: UIPickerViewDataSource {
    
    // MARK: - UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return numbers.count
        case 1:
            return typeModel.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(numbers[row])
        case 1:
            return typeModel[row]
        default:
            return ""
        }
    }
}

extension AddProductView: UIPickerViewDelegate {
    
    // MARK: - UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            if row == 0 {
                self.amountTextField.text = ""
            } else {
                self.amountTextField.text = String(numbers[row]) + " "
            }
        case 1:
            if let currentText = self.amountTextField.text {
                if currentText.isEmpty {
                    return
                }
                for element in typeModel {
                    if currentText.contains(element) {
                        self.amountTextField.text = currentText.replacingOccurrences(of: element, with: "")
                    }
                }
                if typeModel[row].contains("-") {
                    fallthrough
                }
                self.amountTextField.text? += typeModel[row]
            }
        default:
            break
        }
    }
}

extension AddProductView {
    
    // MARK: - AddProductView Methods
    
    private func setupToolBar() {
        let toolbarr = UIToolbar()
        toolbarr.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbarr.setItems([spaceButton, productAddedButton], animated: false)
        productTextField.inputAccessoryView = toolbarr
    }
    
    private func setupPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Constant.done, style: .plain, target: self, action: #selector(amountAddedAction(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        amountTextField.inputAccessoryView = toolbar
        amountTextField.inputView = pickerView
    }
}
