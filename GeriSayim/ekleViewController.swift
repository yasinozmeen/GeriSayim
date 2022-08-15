import UIKit

class ekleViewController: UIViewController {
    @IBOutlet var etkinlikAdiTextField: UITextField!
    @IBOutlet var etkinlikDetayTextField: UITextView!
    @IBOutlet var etkinlikTarihiTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    @IBAction func ekleButton(_ sender: Any) {
        if let ad = etkinlikAdiTextField.text, let tarih = etkinlikTarihiTextField.text, let detay = etkinlikDetayTextField.text{
        EtkinlikDao().etkinlikEkle(etkinlikAdi: ad, etkinlikTarihi: tarih, etkinlikDetay: detay)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
