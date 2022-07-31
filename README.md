# Cosmos.jl

Julia tools for the Cosmos SDK and interacting with Blockchains built on Tendermint.

Relies on `PyCall` and thus you must have Python3 installed and PyCall ENV properly set.

## Installing
```julia
pkg> add https://github.com/schnetzlerjoe/cosmos.jl
```

## Client
```julia
using cosmos

client = NewClient(rpc="")
```

## Wallet
### Generate New Wallet
```julia
wallet = NewWallet()
```

### Recover Wallet
```julia
wallet = NewWallet(mnemonic="")
```

## Transactions
### Generate, Sign and Send Tx
```julia
raw_tx = Dict(
    "type" => "cosmos-sdk/MsgSend",
    "value" => Dict(
        "from_address" => "",
        "to_address" => "",
        "amount" => [
            Dict(
                "denom" => "uatom",
                "amount" => 1000000
            )
        ],
    )
)

tx = NewTx(raw_tx)

tx.sign(wallet)

# Send the signed tx
client.send(tx)
```