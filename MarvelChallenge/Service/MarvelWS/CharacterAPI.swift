//
//  CharacterAPI.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 06/03/2022.
//

import Foundation
import Alamofire

class CharacterAPI {

    typealias completionHandler = (_ responseData: MarvelDTO) -> Void
    typealias errorHandler = (_ errorData: String) -> Void

    let baseUrl = "https://gateway.marvel.com/v1/public"
    let endPoint = "/characters"


    func getCharacters(offset: String = "30", onSuccess: @escaping completionHandler, onError: @escaping errorHandler){

        let url = baseUrl+endPoint
        
        let paramsKeys: Parameters = ["limit":"15",
                                      "offset":offset,
                                      "apikey":"72b06ca6135d2b920ff54e34c671680e",
                                      "hash":"5714ace58a2ab51bc59795131cd7a3d4",
                                      "ts":"1"]
        
        let request = AF.request(url, parameters: paramsKeys, encoding: URLEncoding.default)
        print(request)
        request.responseDecodable(of: MarvelDTO.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let dataResponse):
                onSuccess(dataResponse)
            case .failure(let errorData):
                print(errorData)
                onError(errorData.errorDescription ?? "Error")
            }
        }
    }
}
