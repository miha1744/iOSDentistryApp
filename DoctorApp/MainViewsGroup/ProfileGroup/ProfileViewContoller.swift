//
//  ProfileViewContoller.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 19.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import UIKit

class ProfileViewContoller: YoustersViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(skip))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func skip() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        
        let name = UILabel(text: App.shared.userName, font: Fonts.standart
            .gilroySemiBoldName(ofSize: 35), textColor: .black, textAlignment: .left, numberOfLines: 0)
        view.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        let logOutBut = YoustersButton(text: "Выйти")
        logOutBut.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        view.addSubview(logOutBut)
        logOutBut.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        
        
        
    }
    
    @objc func logOut() {
        self.dismiss(animated: false) {
            App.shared.logOut()
        }
    }
}
