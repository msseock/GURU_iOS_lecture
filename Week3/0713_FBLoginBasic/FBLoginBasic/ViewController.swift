//
//  ViewController.swift
//  FBLoginBasic
//
//  Created by swuad_21 on 2021/07/19.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 소셜 로그인의 기본
        // OAuth2 -> 매번 회원가입하기 힘들다.
        // 가입을 하긴하는데 -> 이 서비스를 써보고싶긴 하지만. 비밀번호를 비롯한 일부 중요 정보를 이 서비스에 저장시켜두기 찝찝하다.
        // 3자 로그인 방식 - FB, Google, Kakao, Naver
        // 중요 정보는 앱 서비스에는 저장 안하고, 필수정보도 3자에게서 받아온다.
        // 내가 -> 앱에 가입 및 로그인
        // 내가 -> 페북 가입 및 로그인 -> 앱에 로그인 인증
        
        // 필수 정보(key)와 중요 정보(비밀번호, 프로필사진, 이메일)
        // 권한 요청 - 페북 - 프로필사진? 이메일주소? 게시글 게시권한, 친구 목록 조회
        
        
        // FBSDKLoginButton 객체를 초기화할 때 로그인 및 로그아웃 이벤트를 받을 대리자를 설정
        let loginButton = FBLoginButton()
        loginButton.permissions = ["email"]
        loginButton.delegate = self
        //  버튼 위치 정하기
        let width = loginButton.frame.width
        let height = loginButton.frame.height
        let screen_width = self.view.frame.width
        let screen_height = self.view.frame.height
        loginButton.frame = CGRect(x: screen_width/2 - width/2, y: screen_height/2 - height/2, width: width, height: height)
        self.view.addSubview(loginButton)
        print("test")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        // 에러가 있으면
        if let error = error {
        print(error.localizedDescription)
        return
        }
        
        // 에러가 없으면
        let credential = FacebookAuthProvider
          .credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            let authError = error as NSError
            print(error.localizedDescription)
            return
          }
            
            if let user = Auth.auth().currentUser {
                if let name = user.displayName {
                    print("welcome \(name)")
                } else {
                    print("이름 없음")
                }
            } else {
                print("firebase 로그인 안되어있음")
            }
          
        }
    }


}

