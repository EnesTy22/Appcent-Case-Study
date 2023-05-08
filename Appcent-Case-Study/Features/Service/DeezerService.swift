//
//  DeezerService.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import Foundation
import Alamofire

protocol DeezerServiceProtocol{
    func request<T:Decodable>(path:String,onSuccess:@escaping (T)->Void,onFail: @escaping (String?)->Void)
}

enum DeezerServicePath: String {
    case BASE_URL = "https://api.deezer.com"
    case GENREPATH = "/genre"
    case ARTISTPATH = "/artist"
    case ARTISTSPATH = "/artists"
    case ALBUMPATH = "/album"
    case ALBUMSPATH = "/albums"

}

struct DeezerService:DeezerServiceProtocol{
    func request<T>(path:String,onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void) where T : Decodable {
        print(path)
        AF.request(path as URLConvertible,method: .get).validate().responseDecodable(of:T.self){ (response) in
            guard let items = response.value else{
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}
