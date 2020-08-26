//
//  DoctorCell.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 19.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import UIKit
import Kingfisher

class DoctorCell: UITableViewCell {
    
    var doctor:Doctor
    
    init(reuseIdentifier:String?, doctor:Doctor) {
        self.doctor = doctor
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        
        
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.fillSuperview()
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 40)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        
        let avatar = UIImageView()
        avatar.kf.setImage(with: URL(string: doctor.avaURL)!)
        avatar.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
        avatar.layer.cornerRadius = 75/2
        avatar.clipsToBounds = true
        
        stackView.addArrangedSubview(avatar)
        
        let vStackView = UIStackView()
        
        stackView.addArrangedSubview(vStackView)
        
        vStackView.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 20)
        vStackView.isLayoutMarginsRelativeArrangement = true
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.alignment = .leading
        vStackView.spacing = 5
        
        let title = UILabel(text: doctor.name, font: Fonts.standart.gilroyMedium(ofSize: 21), textColor: .black, textAlignment: .left, numberOfLines: 0)
        vStackView.addArrangedSubview(title)
        
        let decs = UILabel(text: doctor.prof, font: Fonts.standart.gilroyRegular(ofSize: 17), textColor: .blackTransp, textAlignment: .left, numberOfLines: 0)
        vStackView.addArrangedSubview(decs)
        
//        let statusbgView = UIView()
//        statusbgView.backgroundColor = .bgColor
//        statusbgView.layer.cornerRadius = 5
//        statusbgView.clipsToBounds = true
//
//        statusbgView.addSubview(status)
//
//        status.fillSuperview(padding: .init(top: 4, left: 10, bottom: 4, right: 10))
        
      //  stackView.addArrangedSubview(statusbgView)
        
        accessoryType = .disclosureIndicator
        
//        textLabel?.text = agreement.title
//        textLabel?.font = Fonts.standart.gilroyMedium(ofSize: 21)
//        detailTextLabel?.text = agreement.status.getString()
//        detailTextLabel?.font = Fonts.standart.gilroyRegular(ofSize: 15)
        
    }
}
