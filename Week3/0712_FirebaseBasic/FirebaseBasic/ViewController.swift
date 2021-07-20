//
//  ViewController.swift
//  FirebaseBasic
//
//  Created by swuad_21 on 2021/07/19.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController, FUIAuthDelegate {
    var handle:AuthStateDidChangeListenerHandle!
    let authUI = FUIAuth.defaultAuthUI()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authUI?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let currentUser = auth.currentUser {
                // 로그인된 상태
                NSLog("Logged in")
                if let displayname = currentUser.displayName {
                    // 이름에 따라 alert창 띄우기
                    let alertController = UIAlertController(title: "Welcome", message: "\(displayname)! welcome", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: false, completion: nil)
                }
            } else {
                // 로그아웃된 상태
                NSLog("Logged out")
                let providers: [FUIAuthProvider] = [
                    FUIEmailAuth(),
                    FUIGoogleAuth()
                ]
                self.authUI!.providers = providers
                let authVC = self.authUI!.authViewController()
                authVC.modalPresentationStyle = .fullScreen
                
                self.present(authVC, animated: false, completion: nil)
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("sign in")
        print(authDataResult)
    }

    @IBAction func doSignOut(_ sender: UIButton) {
        // 로그인 상태면 sign out code
        try? authUI?.signOut()
        // 에러가 발생해도 할 게 없으면 이렇게 처리할 수 있다
        
        // key1: let test = try! authUI?.signOut()
        // key2: try? authUI?.signOut()
        /* key3:
                    do {
                        try authUI?.signOut()
                    } catch {
                        print("로그아웃 에러")
                    }
        */
    }
}

extension FUIAuthBaseViewController {
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // cancel 버튼 삭제
        self.navigationItem.leftBarButtonItem = nil
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
