import Cocoa

public class CurriedDemo: BaseDemo {
    
    override public var description : String {
        return "This demo shows how methods are actually curried functions."
    }
    
    public override var URL: NSURL {
        return NSURL(string: "http://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/")
    }
    
    public override func show() {
        class BankAccount {
            var balance: Double = 0.0
            
            func deposit(amount: Double) {
                balance += amount
            }
        }
        
        let account = BankAccount()
        account.deposit(100)
        // balance is now 100
        
        let depositor = BankAccount.deposit
        depositor(account)(100)
        // balance is now 200
        
        println("balance: \(account.balance)")
    }
}
