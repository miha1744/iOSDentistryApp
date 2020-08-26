//
//  SelectTimeViewController.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 19.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import UIKit
import SwiftDate

class SelectTimeViewController: UITableViewController {
    
    let doctor:Doctor
    let service:Service
    
    let cellID = "timeCell"
    
    var events:[Date] = []

    init(doctor:Doctor, service:Service) {
        self.doctor = doctor
        self.service = service
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = "Выберите время"
        
        getDocs()
    }
    
    private func getDocs() {
        DoctorService.main.getDocEvents(pk: doctor.pk) { (result) in
            self.events = result.map({$0.startTime.toDate()!.dateAtStartOf([.hour]).date})
            self.events.forEach({print($0.toString())})
            self.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 20
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        (Date() + section.days).toFormat("dd MMMM", locale: Locale(identifier: "ru")).capitalized(with: Locale(identifier: "ru"))//.toFormat("dd'.'MM'.'yy")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellID)

        let time = (Date().dateAtStartOf(.day) + indexPath.section.days + (9 + indexPath.row).hours)
        cell.textLabel?.text = time.toFormat("HH:mm", locale: Locale(identifier: "ru"))
        cell.textLabel?.font = Fonts.standart.gilroyRegular(ofSize: 16)
        cell.accessoryType = .disclosureIndicator
        
        if events.contains(time) {
            cell.isUserInteractionEnabled = false
            cell.textLabel?.layer.opacity = 0.3
            cell.accessoryType = .none
        }
        

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let time = (Date().dateAtStartOf(.day) + indexPath.section.days + (9 + indexPath.row).hours)
        navigationController?.pushViewController(FinishEventCreation(doctor: doctor, service: service, time: time), animated: true)
    }
    
//    private

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
