//
//  EventListViewController.swift
//  yousters-subs
//
//  Created by Ян Мелоян on 15.06.2020.
//  Copyright © 2020 molidl. All rights reserved.
//

import UIKit

class EventListViewController: YoustersViewController {
    
    let tableView = UITableView()
    let refresher = UIRefreshControl()
    
    let cellID = "eventCell"
        
    var events:[Event] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .backgroundColor
        
        setup()
        getData()
        
        navigationItem.title = "Ваши записи"
        
        navigationItem.rightBarButtonItem = .init(image: .init(imageLiteralResourceName: "user"), style: .plain, target: self, action: #selector(profile))
        navigationItem.rightBarButtonItem?.tintColor = .bgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func profile() {
        let controller = ProfileViewContoller()
        let detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller)
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = detailsTransitioningDelegate
        present(controller, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //if App.shared.isNeedUpdateEvents {
            getData()
        //}
    }
    
    func getData() {
        EventService.main.getEvents { (result) in
            self.events = result
            print(self.events)
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
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EventCell(reuseIdentifier: cellID, event: events[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //navigationController?.pushViewController(SelectDoctorViewController(), animated: true)
    }
    
    

}
