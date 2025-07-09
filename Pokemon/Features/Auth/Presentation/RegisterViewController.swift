//
//  RegisterViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import UIKit
import RxSwift

final class RegisterViewController: UIViewController {
    lazy var root = RegisterView()
    
    private let disposeBag = DisposeBag()
    private let viewModel = AuthInjection.provideAuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Register"
        view = root
        
        dismissKeyboardOnTap()
        
        root.emailTF.textField.delegate = self
        root.nameTF.textField.delegate = self
        root.passwordTF.textField.delegate = self
        
        root.loginBtnTappedHandler = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        setupRX()
        setupBindings()
    }
    
    fileprivate func setupRX() {
        let emailObservable = root.emailTF.textField.rx.text.orEmpty
        let nameObservable = root.nameTF.textField.rx.text.orEmpty
        let passwordObservable = root.passwordTF.textField.rx.text.orEmpty

        Observable
            .combineLatest(emailObservable, nameObservable, passwordObservable)
            .map { email, name, password in
                return !email.isEmpty && !name.isEmpty && !password.isEmpty
            }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isValid in
                self?.root.registerBtn.isEnabled = isValid
                self?.updateButtonState()
            })
            .disposed(by: disposeBag)
        
        
        root.registerBtnTappedHandler = { [weak self] in
            guard let self else { return }
            
            let isEmailExist = viewModel.checkEmailExists(root.emailTF.textField.text ?? "")
            
            if !isEmailExist {
                viewModel.register(
                    name: root.nameTF.textField.text ?? "",
                    email: root.emailTF.textField.text ?? "",
                    password: root.passwordTF.textField.text ?? ""
                )
            } else {
                showAlert("Oops!", message: "Email has been taken!")
            }
            
        }
    }
    
    fileprivate func setupBindings() {
        viewModel.isRegistered
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                
                if result == true {
                    showAlert("Yayy!", message: "Register Account Successfully!") { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
//                } else {
//                    showAlert("Failed", message: "Failed to register account!")
//                }
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func updateButtonState() {
        // Check if the button is enabled or disabled
        if root.registerBtn.isEnabled {
            root.registerBtn.backgroundColor = .baseColor // Enabled state color
        } else {
            root.registerBtn.backgroundColor = .lightGray.withAlphaComponent(0.5) // Disabled state color
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            if let responder: UIResponder = view.viewWithTag(textField.tag + 1) {
                guard responder.isKind(of: UITextField.self) else { return true }
                responder.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
