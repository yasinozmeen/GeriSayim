import UIKit

class detayViewController: UIViewController {
    @IBOutlet var etkinlikAdiTextFeld: UITextField!
    @IBOutlet var etkinlikTarihiTextField: UITextField!
    @IBOutlet var detayTextField: UITextField!
    
    var datePicker:UIDatePicker?
    
    var etkinlik = Etkinlik()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        etkinlikTarihiTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(tarihGoster(datePicker:)), for: .allEvents)
        
        
        if let ad = etkinlik.etkinlikAdi, let tarih = etkinlik.etkinlikTarihi, let detay = etkinlik.etkinlikDetay{
            etkinlikAdiTextFeld.text = ad
            etkinlikTarihiTextField.text = tarih
            detayTextField.text = detay
        }
       
    }
    
    @objc func tarihGoster(datePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MM-yyyy HH:mm"
        let alınanTarih = dateFormatter.string(from: datePicker.date)
        etkinlikTarihiTextField.text = alınanTarih
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }// ekrana tıklanınca klavyenin yok olması
    
    @IBAction func guncelleButton(_ sender: Any) {
      
        if etkinlikTarihiTextField.text == ""{
            etkinlikTarihiTextField.placeholder = "Lütfen tarih seçimi yapın!!!!"
        }else{
            if let id = etkinlik.etkinlikId, let ad = etkinlikAdiTextFeld.text, let tarih = etkinlikTarihiTextField.text, let detay = detayTextField.text{
                
                let formatter = DateFormatter()
                formatter.dateFormat = "d-MM-yyyy HH:mm"
                
                
                let etkinlikTarihi = formatter.date(from: tarih)
                let diffSeconds = etkinlikTarihi!.timeIntervalSinceReferenceDate - Date().timeIntervalSince1970
               
                print(diffSeconds)
                EtkinlikDao().etkinlikGuncelle(etkinlikId: id, etkinlikAdi: ad, etkinlikTarihi: tarih, etkinlikDetay: detay, etkinlikSaniye: Int(diffSeconds))
                navigationController?.popViewController(animated: true)
            }
        }
        
//
//        if let id = etkinlik.etkinlikId, let ad = etkinlikAdiTextFeld.text, let tarih = etkinlikTarihiTextField.text, let detay = detayTextField.text, let saniye = etkinlik.etkinlikSaniye{
//
//            EtkinlikDao().etkinlikGuncelle(etkinlikId: id, etkinlikAdi: ad, etkinlikTarihi: tarih, etkinlikDetay: "", etkinlikSaniye:saniye )
//            ViewController.liste = EtkinlikDao().tumEtkinliklerAL()
//
//            navigationController?.popViewController(animated: true)
//        }
        
        
        
    }
    
}

