//
//  DatabaseEntity.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation


struct ServerEntity : Storable
{
    var baseUrl: String = "https://api.demo.artistconnection.net"
    var serverToken: SignUpData? = nil
}

struct UserEntity: Storable
{
    var Username:String = ""
    var Password:String = ""
    var Office:String = ""
}
