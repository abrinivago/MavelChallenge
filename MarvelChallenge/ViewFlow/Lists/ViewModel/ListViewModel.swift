//
//  ListViewModel.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 06/03/2022.
//

import Foundation

class ListViewModel {
    let eventAPI = EventsAPI()
    let characterAPI = CharacterAPI()
    var listData: DataClass? {
        didSet {
            self.bindRequestData(listData?.results)
        }
    }
    var totalCount: Int?
    
    var bindStartRequest = {() -> Void in }
    var bindEndRequest = {() -> Void in }
    var bindErrorMessage = {(_ errorMessage: String) -> Void in }
    var bindRequestData = {(_ arrayList: [Results]?) -> Void in }

    func getCharacter(_ offset: String = "0") {
        bindStartRequest()
        characterAPI.getCharacters(offset: offset){ responseData in
            self.listData = responseData.data
            self.totalCount = responseData.data?.total
            self.bindEndRequest()
        } onError: { errorData in
            self.bindEndRequest()
            self.bindErrorMessage(errorData.debugDescription)
        }
    }
    
    func getEvents(_ offset: String = "0") {
        bindStartRequest()
        eventAPI.getEvents(offset: offset){ responseData in
            self.listData = responseData.data
            self.totalCount = responseData.data?.total
            self.bindEndRequest()
        } onError: { errorData in
            self.bindEndRequest()
            self.bindErrorMessage(errorData.debugDescription)
        }
    }
}



