//
//  NewListViewController.swift
//  ToTheStore
//
//  Created by Василий on 07.01.2023.
//

import UIKit
import SnapKit

final class NewListViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: NewListPresenterInput!
    
    var productModel: [ProductModel] = [] {
        didSet {
            productModel.count == 0 ? (emptyListLabel.isHidden = false) : (emptyListLabel.isHidden = true)
        }
    }
    
    private let addProductView = CreateEntityView(state: .newProduct)
    private let emptyListLabel = UILabel(.systemFont(ofSize: 20), .black,  Constant.emptyList)
    
    private let listDescriptionTextField: UITextField = {
        let listDescriptionTextField = UITextField()
        listDescriptionTextField.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        listDescriptionTextField.textColor = .black
        listDescriptionTextField.attributedPlaceholder = NSAttributedString(
            string: Constant.listDescription,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        return listDescriptionTextField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(dataSource: self, delegate: self, backGroundColor: Colors.mainBackground)
        tableView.registerCell(type: ProductCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.mainBackground
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Instance methods
    
    override func setup() {
        super.setup()
        addGestureRecognizers()
        setupNavigationBar()

        view.addSubviews([listDescriptionTextField, addProductView, tableView, emptyListLabel])

        listDescriptionTextField.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            maker.left.equalTo(view.snp.left).offset(20)
        }
        
        addProductView.snp.makeConstraints { maker in
            maker.top.equalTo(listDescriptionTextField.snp.bottom).offset(20)
            maker.left.equalTo(view.snp.left).offset(20)
            maker.right.equalTo(view.snp.right).inset(20)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(addProductView.snp.bottom).offset(20)
            maker.left.equalTo(view.snp.left).offset(20)
            maker.right.equalTo(view.snp.right).inset(20)
            maker.bottom.equalToSuperview()
        }
        
        emptyListLabel.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    @objc
    private func dismissActions() {
        view.endEditing(true)
    }
    
    @objc
    private func showNewProductViewAction() {
        presenter.showAddProductView()
    }
}

extension NewListViewController {
    
    // MARK: - Instance methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false

        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.mainBackground
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .black
        let shareRightBarButton = UIBarButtonItem(image: Images.share, style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [shareRightBarButton]
    }
    
    private func addGestureRecognizers() {
        let mainRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissActions))
        view.addGestureRecognizer(mainRecognizer)
        
        let procuctViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(showNewProductViewAction))
        addProductView.addGestureRecognizer(procuctViewRecognizer)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension NewListViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: ProductCell.self, for: indexPath) as! ProductCell
        cell.configure(productModel[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = productModel[sourceIndexPath.row]
        productModel.remove(at: sourceIndexPath.row)
        productModel.insert(movedItem, at: destinationIndexPath.row)
    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView.init(frame: .zero)
//    }
}

extension NewListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate method
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let indexSet = IndexSet(integer: indexPath.section)
            self.productModel.remove(at: indexPath.section)

            self.tableView.beginUpdates()
            self.tableView.deleteSections(indexSet, with: .automatic)
            self.tableView.endUpdates()
        }
    }
}

extension NewListViewController: NewListViewOutput {
    
    // MARK: - NewListViewOutput methods
    
    func showAddProductView() {
        Router.shared.present(for: .newProduct({ [weak self] newProduct in
            guard let self = self else { return }
            self.productModel.append(newProduct)
            self.reloadData()
        }))
    }
}
