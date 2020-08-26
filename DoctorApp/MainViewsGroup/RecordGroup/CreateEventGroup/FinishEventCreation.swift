//
//  FinishEventCreation.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 11.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//
import UIKit

class FinishEventCreation: YoustersStackViewController {
    
    let doctor:Doctor
    let service:Service
    let date:Date
    
    init(doctor:Doctor, service:Service, time:Date) {
        self.doctor = doctor
        self.service = service
        self.date = time
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Запись"
        
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 35
        
        addDoctorName()
        setupView()
        
        EventService.main.getServices { (result) in
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBut() {
        let sendButton = YoustersButton(text: "Записаться")
        addWidthArrangedSubView(view: sendButton)
        sendButton.addTarget(self, action: #selector(send), for: .touchUpInside)
    }
    
    private func setupView() {
        addSubTitle(title: "Название")
        addTitle(title: service.title)
        addSubTitle(title: "Описание")
        addTitle(title: service.desc)
        addSubTitle(title: "Время")
        addTitle(title: date.toFormat("dd MMM yyyy 'в' HH:mm", locale: Locale(identifier: "ru")))
        
        
        setupBut()
    }
    
    private func addDoctorName() {
        addSubTitle(title: "Вы выбрали:")
        addTitle(title: doctor.name)
    }
    
    private func addTitle(title:String) {
        let label = UILabel(text: title, font: Fonts.standart.gilroyMedium(ofSize: 18), textColor: .bgColor, textAlignment: .left, numberOfLines: 0)
        addWidthArrangedSubView(view: label)
    }
    
    private func addSubTitle(title:String) {
        let label = UILabel(text: title, font: Fonts.standart.gilroyRegular(ofSize: 15), textColor: .blackTransp, textAlignment: .left, numberOfLines: 0)
        addWidthArrangedSubView(view: label, spacing: 5)
    }
    
    @objc private func send() {
        let event = Event(title: service.title, desc: service.desc, startTime: date.toISO(), doctorName: doctor.pk)
        
        let alert = UIAlertController(style: .loading)
        self.present(alert, animated: true, completion: nil)
        
        EventService.main.createEvent(event: event) { (result) in
            alert.dismiss(animated: false) {
                if result {
                    App.shared.isNeedUpdateEvents = true
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
