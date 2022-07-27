import UIKit

struct ExchangeRate{
    var currencyRate : Double {
        willSet{
            print("currencyRate willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
        }
        didSet{
            print("currencyRate didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
    }
    
    var USD : Double {
        willSet{
            print("USD WillSet - 환전금액: USD: \(newValue) 변경예정") //newValue = KRW/currentRate

        }
        didSet{
            print("USD didSEt - KRW :\(KRW) -> \(USD)달러로 환전됨. ")

        }
        
    }
    var KRW : Double{
        get{
            USD*currencyRate
        }
        set{
            USD = newValue / currencyRate
        }
    }
    
    init(currencyRate: Double,USD:Double){
        self.currencyRate = currencyRate
        self.USD = USD
    }
    
}
var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000

