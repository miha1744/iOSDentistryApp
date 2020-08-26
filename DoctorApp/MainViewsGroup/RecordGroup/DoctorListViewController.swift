//
//  DoctorListViewController.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 19.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import UIKit

class DoctorListViewController: YoustersViewController {
    
    let tableView = UITableView()
    let refresher = UIRefreshControl()
    
    let cellID = "doctorCell"
        
    var doctor:[Doctor] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .backgroundColor
        
        setup()
        getData()
        
        navigationItem.title = "Доктора"
        navigationItem.rightBarButtonItem = .init(image: .init(imageLiteralResourceName: "user"), style: .plain, target: self, action: #selector(profile))
        navigationItem.rightBarButtonItem?.tintColor = .bgColor

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc private func profile() {
        let controller = ProfileViewContoller()
        let detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller)
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = detailsTransitioningDelegate
        present(controller, animated: true, completion: nil)
    }
    
    func getData() {
        DoctorService.main.getDocs { (result) in
            self.doctor = result
            print(self.doctor)
            self.tableView.reloadData()
            self.refresher.endRefreshing()
            App.shared.isNeedUpdateEvents = false
        }
    }
    
    private func setup() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        
        refresher.tintColor = .bgColor
        refresher.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refresher)
        extendedLayoutIncludesOpaqueBars = true
    }
    
    @objc func refresh(sender:AnyObject){
        getData()
    }
    
//    @objc private func add() {
//        
//            navigationController?.pushViewController(SelectDoctorViewController(), animated: true)
//    }
}

extension DoctorListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doctor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DoctorCell(reuseIdentifier: cellID, doctor: doctor[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SelectServiceViewController(doctor: doctor[indexPath.row]), animated: true)
        //navigationController?.pushViewController(SelectDoctorViewController(), animated: true)
    }
    
    

}
