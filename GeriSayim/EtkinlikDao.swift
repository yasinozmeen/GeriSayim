//
//  EtkinlikDao.swift
//  GeriSayim
//
//  Created by Kadir Yasin Özmen on 14.08.2022.
//

import Foundation

class EtkinlikDao{
    let db:FMDatabase?
    init(){
        let hedefYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabanıURL = URL(fileURLWithPath: hedefYolu).appendingPathComponent("EtkinlikDB.db")
        
        db = FMDatabase(path: veritabanıURL.path)
    }
    
    func tumEtkinliklerAL() -> [Etkinlik]{
        var liste = [Etkinlik]()
        db?.open()
        
        do{
            let rs =  try db!.executeQuery("SELECT * FROM Etkinlik", values: nil)
            while rs.next(){
                let etkinlik = Etkinlik(etkinlikId: Int(rs.string(forColumn: "etkinlikId") ?? "hata")!, etkinlikAdi: rs.string(forColumn: "etkinlikAd") ?? "hata" , etkinlikTarihi: rs.string(forColumn: "etkinlikTarih") ?? "hata" , etkinlikDetay: rs.string(forColumn: "etkinlikDetay") ?? "Hata")
                liste.append(etkinlik)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        return liste
    }
    
    func etkinlikEkle(etkinlikAdi:String,etkinlikTarihi:String,etkinlikDetay:String){
        db?.open()
        
        do{
            try db?.executeUpdate("INSERT INTO Etkinlik (etkinlikAd,etkinlikTarih,etkinlikDetay) VALUES (?,?,?)", values: [etkinlikAdi,etkinlikTarihi,etkinlikDetay])
        }catch{
            print(error.localizedDescription)
            
        }
        
        db?.close()
    }
}
