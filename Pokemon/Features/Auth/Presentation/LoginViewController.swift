//
//  LoginViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController {
    lazy var root = LoginView()
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = AuthInjection.provideAuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Login"
        view = root
        
        dismissKeyboardOnTap()
        
        root.emailTF.textField.delegate = self
        root.passwordTF.textField.delegate = self
        
        root.registerBtnTappedHandler = { [weak self] in
            self?.navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
        
        setupRX()
        setupBindings()
    }
    
    fileprivate func setupRX() {
        let emailObservable = root.emailTF.textField.rx.text.orEmpty
        let passwordObservable = root.passwordTF.textField.rx.text.orEmpty

        Observable
            .combineLatest(emailObservable, passwordObservable)
            .map { email, password in
                return !email.isEmpty && !password.isEmpty
            }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isValid in
                self?.root.loginBtn.isEnabled = isValid
                self?.updateButtonState()
            })
            .disposed(by: disposeBag)
        
        
        root.loginBtnTappedHandler = { [weak self] in
            guard let self else { return }
            
            viewModel.login(email: root.emailTF.textField.text ?? "", password: root.passwordTF.textField.text ?? "")
        }
    }
    
    fileprivate func setupBindings() {
        viewModel.authResult
            .asObservable()
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let model):
                    UserDefaults.standard.set(model?.email, forKey: "email")
                    UserDefaults.standard.set(model?.name, forKey: "name")
                    
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    appDelegate?.window?.rootViewController = UINavigationController(rootViewController: TabbarViewController())
                    
                    guard let window = appDelegate?.window else { return }
                    UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: nil, completion: nil)
                    
                case .loading:
                    root.loginBtn.isEnabled = false
                    
                case .failure(let errorMessage):
                    showAlert("Error", message: errorMessage)
                    
                    root.loginBtn.isEnabled = true
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    fileprivate func updateButtonState() {
        // Check if the button is enabled or disabled
        if root.loginBtn.isEnabled {
            root.loginBtn.backgroundColor = .baseColor // Enabled state color
        } else {
            root.loginBtn.backgroundColor = .lightGray.withAlphaComponent(0.5) // Disabled state color
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
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
