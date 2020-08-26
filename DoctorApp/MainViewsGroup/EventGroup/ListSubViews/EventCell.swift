//
//  EventCell.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 11.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    var event:Event
    
    let stackView = UIStackView()
    
    init(reuseIdentifier:String?, event:Event) {
        self.event = event
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(stackView)
        stackView.fillSuperview()
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 40)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10.0
        
        let title = UILabel(text: event.title, font: Fonts.standart.gilroyMedium(ofSize: 21), textColor: .black, textAlignment: .left, numberOfLines: 0)
        stackView.addArrangedSubview(title)
        
        let decs = UILabel(text: event.desc, font: Fonts.standart.gilroyRegular(ofSize: 17), textColor: .blackTransp, textAlignment: .left, numberOfLines: 0)
        stackView.addArrangedSubview(decs)
        
        let status = UILabel(text: event.getPeriod() + " к " + event.doctorName, font: Fonts.standart.gilroyRegular(ofSize: 14), textColor: .white, textAlignment: .left, numberOfLines: 1)
        
        let statusbgView = UIView()
        statusbgView.backgroundColor = .bgColor
        statusbgView.layer.cornerRadius = 5
        statusbgView.clipsToBounds = true
        
        statusbgView.addSubview(status)
        
        status.fillSuperview(padding: .init(top: 4, left: 10, bottom: 4, right: 10))
        
        stackView.addArrangedSubview(statusbgView)
        
        //accessoryType = .disclosureIndicator
        
//        textLabel?.text = agreement.title
//        textLabel?.font = Fonts.standart.gilroyMedium(ofSize: 21)
//        detailTextLabel?.text = agreement.status.getString()
//        detailTextLabel?.font = Fonts.standart.gilroyRegular(ofSize: 15)
        
    }
}

