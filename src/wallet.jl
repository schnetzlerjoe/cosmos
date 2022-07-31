using PyCall

cosmos = pyimport("cosmospy")

function NewWallet(prefix::String="cosmos", mnemonic::String="", path::String="m/44'/118'/0'/0/0")
    if mnemonic == ""
        wallet = cosmos.generate_wallet(hrp=prefix, path=path)
    else
        privkey = cosmos.seed_to_privkey(seed=mnemonic, path=path)
        pubkey = cosmos.privkey_to_pubkey(PyCall.pybytes(privkey))
        address = cosmos.privkey_to_address(privkey=PyCall.pybytes(privkey), hrp=prefix)
        wallet = Dict(
            "seed" => mnemonic,
            "derivation_path" => path,
            "private_key" => PyCall.pybytes(privkey),
            "public_key" => PyCall.pybytes(pubkey),
            "address" => address,
        )
    end
    return wallet
end
