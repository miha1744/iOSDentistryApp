//
//  SelectDoctorViewController.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 11.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import UIKit

class SelectServiceViewController: UITableViewController {
    
    var doctor:Doctor
    var servicies:[Service] = []
    
    let cellID = "serviceCell"

    init(doctor:Doctor) {
        self.doctor = doctor
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = "Выберите услугу"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title ?? "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.standart.gilroySemiBoldName(ofSize: 16)], for: .normal)
        
        getDocs()
        
        tableView.tableFooterView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getDocs() {
        EventService.main.getServices { (result) in
            self.servicies = result
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)

        cell.textLabel?.text = servicies[indexPath.row].title
        cell.textLabel?.font = Fonts.standart.gilroyMedium(ofSize: 20)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.font = Fonts.standart.gilroyRegular(ofSize: 15)
        cell.detailTextLabel?.text = servicies[indexPath.row].desc
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SelectTimeViewController(doctor: doctor, service: servicies[indexPath.row]), animated: true)
    }


}
