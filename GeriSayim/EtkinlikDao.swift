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
  
    var resim = ViewController.image
    var sqlSiralama = "SELECT * FROM Etkinlik ORDER BY etkinlikId ASC"
    
    func tumEtkinliklerAL() -> [Etkinlik]{
        
        switch resim {
        case "xmark":
            sqlSiralama = "SELECT * FROM Etkinlik ORDER BY etkinlikId ASC"
        case "lessthan":
            sqlSiralama = "SELECT * FROM Etkinlik ORDER BY etkinlikSaniye ASC"
        case "greaterthan":
            sqlSiralama = "SELECT * FROM Etkinlik ORDER BY etkinlikSaniye DESC"
        default:
            sqlSiralama = "SELECT * FROM Etkinlik"
        }
        
        var liste = [Etkinlik]()
        db?.open()
        
        do{
            let rs =  try db!.executeQuery(sqlSiralama, values: nil)
            while rs.next(){
                let etkinlik = Etkinlik(etkinlikId: Int(rs.string(forColumn: "etkinlikId") ?? "hata")!, etkinlikAdi: rs.string(forColumn: "etkinlikAd") ?? "hata" , etkinlikTarihi: rs.string(forColumn: "etkinlikTarih") ?? "hata" , etkinlikDetay: rs.string(forColumn: "etkinlikDetay") ?? "Hata",etkinlikSaniye: Int(rs.string(forColumn: "etkinlikSaniye") ?? "Hata")! )
                liste.append(etkinlik)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        return liste
    }
    
    func etkinlikEkle(etkinlikAdi:String,etkinlikTarihi:String,etkinlikDetay:String,etkinlikSaniye:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO Etkinlik (etkinlikAd,etkinlikTarih,etkinlikDetay,etkinlikSaniye) VALUES (?,?,?,?)", values: [etkinlikAdi,etkinlikTarihi,etkinlikDetay,etkinlikSaniye])
        }catch{
            print(error.localizedDescription)
            
        }
        
        db?.close()
    }
    
    func etkinlikSil(etkinlikId:Int){
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM Etkinlik WHERE etkinlikId = ?", values: [etkinlikId])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
     
        func etkinlikGuncelle(etkinlikId:Int,etkinlikAdi:String,etkinlikTarihi:String,etkinlikDetay:String,etkinlikSaniye:Int){
            db?.open()
    
            do{
                try db!.executeUpdate("UPDATE Etkinlik SET etkinlikAd = ?, etkinlikTarih=?, etkinlikDetay=?,etkinlikSaniye=? WHERE etkinlikId = ? ", values: [etkinlikAdi,etkinlikTarihi,etkinlikDetay,etkinlikSaniye,etkinlikId])
                print("eklendi")
            }catch{
                print(error.localizedDescription)
    
            }
    
            db?.close()
        }
}
