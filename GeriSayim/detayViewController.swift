import UIKit

class detayViewController: UIViewController {
    @IBOutlet var etkinlikAdiTextFeld: UITextField!
    @IBOutlet var etkinlikTarihiTextField: UITextField!
    @IBOutlet var detayTextField: UITextField!
    
    
    var etkinlik = Etkinlik()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ad = etkinlik.etkinlikAdi, let tarih = etkinlik.etkinlikTarihi, let detay = etkinlik.etkinlikDetay{
            etkinlikAdiTextFeld.text = ad
            etkinlikTarihiTextField.text = tarih
            detayTextField.text = detay
        }
       
    }
    @IBAction func guncelleButton(_ sender: Any) {
//        if let id = etkinlik.etkinlikId, let ad = etkinlikAdiTextFeld.text, let tarih = etkinlikTarihiTextField.text, let detay = detayTextField.text{
//            EtkinlikDao().etkinlikGuncelle(etkinlikId: id, etkinlikAdi: ad, etkinlikTarihi: tarih, etkinlikDetay: detay)
//            print(type(of: id))
//        }
//        navigationController?.popViewController(animated: true)
//   //     GlobalListArray.sharedList.list = EtkinlikDao().tumEtkinliklerAL()
    }
    
}
