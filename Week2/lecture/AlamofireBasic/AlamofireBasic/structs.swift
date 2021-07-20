//
//  structs.swift
//  AlamofireBasic
//
//  Created by swuad_21 on 2021/07/15.
//
import UIKit

struct DummyData:Codable {
    let data:[PersonInfo]
    let total:Int
    let page:Int
    let limit:Int
    let offset:Int
}

struct PersonInfo:Codable {
    let id:String
    let title:String
    let firstName:String
    let lastName: String
    let email: String
    let picture:URL?
}

struct PersonDetail:Codable{
    let id:String
    let title:String
    let firstName:String
    let lastName:String
    let gender:String
    let email:String
    let dateOfBirth:String
    let phone:String
    let picture:URL
    let location:Location?
    let registerDate:String
    let updatedAt:String
}

struct Location:Codable {
    let street:String
    let city:String
    let state:String
    let country:String
    let timezone:String
}
