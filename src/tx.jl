using PyCall
include("wallet.jl")

cosmos = pyimport("cosmospy")

wallet = NewWallet("defund", "usage exit wrap airport odor coyote flavor reveal image vendor protect dove scout runway blood enforce armed wasp vibrant toast space radio check raven")

function CreateTx(wallet, fee::Int=1000, gas::Int=70000, memo::String="", chain_id::String="cosmoshub-4")
    tx = cosmos.Transaction(
        privkey=wallet["private_key"],
        account_num=0,
        sequence=0,
        fee=fee,
        gas=gas,
        memo=memo,
        chain_id=chain_id,
        sync_mode="sync",
    )
    return tx
end

function AddTx(tx)
    println(tx)
    transfer = Dict(
        "type" => "cosmos-sdk/MsgSend",
        "value" => Dict(
            "from_address" => wallet["address"],
            "to_address" => wallet["address"],
            "amount" => [Dict("denom" => "uatom", "amount" => 1000000)],
        ),
    )
    tx._msgs = tx._msgs.append(PyCall.PyDict(transfer))
    return tx
end

tx = CreateTx(wallet)

println(AddTx(tx))