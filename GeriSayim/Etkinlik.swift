//
//  Etkinlik.swift
//  GeriSayim
//
//  Created by Kadir Yasin Özmen on 13.08.2022.
//

import Foundation

class Etkinlik{
    var etkinlikId:Int?
    var etkinlikAdi:String?
    var etkinlikTarihi:String?
    var etkinlikDetay:String?
    
    init() {
        
    }
    init(etkinlikId:Int,etkinlikAdi:String,etkinlikTarihi:String,etkinlikDetay:String) {
        self.etkinlikId = etkinlikId
        self.etkinlikAdi = etkinlikAdi
        self.etkinlikTarihi = etkinlikTarihi
        self.etkinlikDetay = etkinlikDetay
    }
}
