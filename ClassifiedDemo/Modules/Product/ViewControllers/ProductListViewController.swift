//
//  ProductListViewController.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

protocol ProductView: class {
    func showClassifiedItems()
    func showError()
}

class ProductListViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var productsTableView: UITableView!
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    var presenter: ProductPresenter?
    var loadingTimer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = CPLocalizeText.TEXT_CLASSIFIED_ITEMS
        self.activityIndicatorView = UIActivityIndicatorView(style: .large)
        
        setUpTabBar()
        setUpSegmentControl()
        setUpTableView()
        
        // Load data from presenter
        presenter?.loadViewData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        setUpNavigationBar()
        
        if productsTableView.numberOfRows(inSection: 0) == 0 {
            self.startLoadingPopup()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.loadingTimer?.invalidate()
        self.loadingTimer = nil
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        let selectedSegment = ClassifiedListSegmentIndex(rawValue: sender.selectedSegmentIndex) ?? .Name
        
        // Sort list
        presenter?.sortClassifiedList(by: selectedSegment)
        
        // Reload table
        self.productsTableView.reloadData()
    }
    
    // MARK: Methods
    
    private func setUpSegmentControl() {
        self.segmentControl.setTitle(CPLocalizeText.TEXT_NAME, forSegmentAt: 0)
        self.segmentControl.setTitle(CPLocalizeText.TEXT_PRICE, forSegmentAt: 1)
    }
    
    private func setUpNavigationBar() {
        self.navigationItem.title = "Products"
        self.navigationItem.titleView = self.segmentControl;
        self.navigationController?.navigationBar.prefersLargeTitles = true;
    }
    
    private func setUpTabBar() {
        self.navigationController?.tabBarItem.image = UIImage(systemName: "house")
        self.navigationController?.tabBarItem.title = "Home"
    }
    
    private func setUpTableView() {
        productsTableView.dataSource = self
        productsTableView.delegate = self
        
        // Set activity indicator
        productsTableView.backgroundView = activityIndicatorView
        productsTableView.separatorStyle = .none
        
        productsTableView.register(ProductListTableViewCell.loadNib(),
                                forCellReuseIdentifier: ProductListTableViewCell.reuseIdentifier())
    }
    
    private func pushToDetailViewController(for index: Int) {
        let item = presenter?.getClassifiedItem(at: index)
        let detailViewController = ProductDetailViewController(nibName: ProductDetailViewController.nibName(), bundle: nil)
        detailViewController.selectedProduct = item

        if let detailPresenter = self.presenter as? ProductListPresenter {
            detailViewController.presenter = detailPresenter
        }
        
        // Move to next page
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK:- UITableViewDataSource
extension ProductListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ClassifiedListSectionIdentifier.sectionCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionId = ClassifiedListSectionIdentifier(rawValue: section) ?? .sectionCount
        
        switch sectionId {
        case .section1:
            let count = presenter?.getclassifiedProductsCount() ?? 0
            return count
            
        case .sectionCount:
            fallthrough
            
        @unknown default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = ProductListTableViewCell.reuseIdentifier()
        
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: cellIdentifier,
                                 for: indexPath) as? ProductListTableViewCell else {
            
            print("The dequeued cell is not an instance of ProductListTableViewCell")
            return UITableViewCell()
        }
        
        // Fetches the appropriate item for the data source layout.
        let item = presenter?.getClassifiedItem(at: indexPath.row)
        cell.itemNameLabel.text = item?.name?.capitalized ?? ""
        cell.itemPriceLabel.text = item?.price ?? "0"
        
        if let imageName = item?.imageUrlsThumbnails?.first {
            self.presenter?.onFetchThumbnail(name: imageName) { image in
                cell.itemThumbnailImageView.image = image
            }
            
            cell.itemThumbnailImageView.image = UIImage(named: "defaultPhoto")
        }
        
        // Style Cell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK:- UITableViewDelegate
extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.pushToDetailViewController(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let itemCount = presenter?.getclassifiedProductsCount() ?? 0
        return "\(itemCount) Items"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

extension ProductListViewController: ProductView {
    func showClassifiedItems() {
        self.stopLoadingPopup()
        
        self.productsTableView.separatorStyle = .singleLine
        self.productsTableView.reloadData()
    }
    
    func showError() {
        // Stop loading
        self.stopLoadingPopup()
        
        let alert = UIAlertController(title: CPLocalizeText.TEXT_ALERT,
                                      message: CPLocalizeText.TEXT_PROBLEM_FETCHING_CLASSIFIED_ITEMS,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let alertOkAction = UIAlertAction(title: CPLocalizeText.TEXT_OK,
                                          style: .default, handler: {(_: UIAlertAction) in
            
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(alertOkAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ProductListViewController {
    
    func startLoadingPopup() {
        self.startLoadingTimer()
        self.activityIndicatorView.startAnimating()
    }
    
    func stopLoadingPopup() {
        self.stopLoadingTimer()
        self.activityIndicatorView.stopAnimating()
    }
    
    func startLoadingTimer() -> Void {
        self.loadingTimer?.invalidate()
        self.loadingTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(actionOnTimerExpire), userInfo: nil, repeats: false)
    }
    
    @objc func actionOnTimerExpire() -> Void {
        self.stopLoadingPopup()
    }
    
    func stopLoadingTimer() -> Void {
        self.loadingTimer?.invalidate()
        self.loadingTimer = nil
    }
}

