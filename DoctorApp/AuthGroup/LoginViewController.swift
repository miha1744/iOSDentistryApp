//
//  LoginViewController.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 11.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import UIKit
import LBTATools
import SnapKit

class LoginViewController: YoustersViewController {
    
    let button = YoustersButton(text: "Авторизоваться", fontSize: 18)
    let regButton = YoustersButton(text: "Регистрация", fontSize: 18)
    
    let loginField = YoustersTextField(placehldr: "Логин")
    let passField = YoustersTextField(placehldr: "Пароль")
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        
        bottomOffset = -230
        bottomPaddinng = 15
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        let label = UILabel(text: "Dentestry App", font: Fonts.standart.gilroySemiBoldName(ofSize: 35), textColor: .bgColor, textAlignment: .left, numberOfLines: 0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(55)
        }
        
        let desc = UILabel(text: "Запись без проблем", font: Fonts.standart.gilroyRegular(ofSize: 17), textColor: .blackTransp, textAlignment: .left, numberOfLines: 0)
        view.addSubview(desc)
        
        desc.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        
        button.backgroundColor = .mainColor
        view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            self.bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(bottomOffset).constraint
        }
        button.isEnabled = false
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        let orLabel = UILabel(text: " - или -", font: Fonts.standart.gilroyRegular(ofSize: 16), textColor: .blackTransp, textAlignment: .center, numberOfLines: 0)
        view.addSubview(orLabel)
        orLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(25)
            make.top.equalTo(button.snp.bottom).offset(10)
        }
        
        regButton.backgroundColor = .mainColor
        view.addSubview(regButton)
        
        regButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(orLabel.snp.bottom).offset(10)
        }
        regButton.addTarget(self, action: #selector(toReg), for: .touchUpInside)
        
        view.addSubview(passField)
        passField.autocapitalizationType = .none
        passField.autocorrectionType = .no
        passField.isSecureTextEntry = true
        
        passField.snp.makeConstraints { (make) in
            make.bottom.equalTo(button.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(loginField)
        loginField.autocapitalizationType = .none
        loginField.autocorrectionType = .no
        
        loginField.snp.makeConstraints { (make) in
            make.bottom.equalTo(passField.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        loginField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        passField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
    }
    
    @objc private func textFieldDidChange(textField: UITextField){
        button.isEnabled = (!loginField.text!.isEmpty && !passField.text!.isEmpty)
        
    }
    
    @objc private func tapped() {
        
        let alert = UIAlertController(style: .loading)
        self.present(alert, animated: true, completion: nil)
        
        AuthService.main.auth(login: loginField.text!, pass: passField.text!) { (result) in
            alert.dismiss(animated: false) {
                if result {
                    let vc = MainTabBarController()
                    RouteProvider.switchRootViewController(rootViewController: vc, animated: true, completion: nil)
                } else {
                    print("error auth")
                }
            }
        }
        
    }
    
    @objc private func toReg() {
        
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
