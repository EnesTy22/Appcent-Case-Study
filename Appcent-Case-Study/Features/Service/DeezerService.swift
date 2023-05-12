import Foundation
import Alamofire

protocol DeezerServiceProtocol{
    func request<T:Decodable>(path: String,onSuccess:@escaping (T)->Void,onFail: @escaping (String?)->Void, method: HTTPMethod?)
}

enum DeezerServicePath: String {
    case BASE_URL = "https://api.deezer.com"
    case GENREPATH = "/genre"
    case ARTISTPATH = "/artist"
    case ARTISTSPATH = "/artists"
    case ALBUMPATH = "/album"
    case ALBUMSPATH = "/albums"
    case TRACKPATH = "/track"

}

struct DeezerService: DeezerServiceProtocol{
    static let shared = DeezerService()
    
    func request<T>(path: String,onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void, method: HTTPMethod? = .get) where T : Decodable {
        AF.request(DeezerServicePath.BASE_URL.rawValue + path,method: method ?? .get).validate().responseDecodable(of:T.self){ (response) in
            guard let items = response.value else{
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}

