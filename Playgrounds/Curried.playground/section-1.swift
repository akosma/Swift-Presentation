// http://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/

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
