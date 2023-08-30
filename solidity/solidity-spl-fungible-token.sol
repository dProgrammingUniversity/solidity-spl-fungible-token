import "../libraries/spl_token.sol";
import "../libraries/mpl_metadata.sol";

@program_id("GbWt4JoWpfAXEeNEkrDyinpkwz3tPB3KCUY98abFTXr4")
contract spl_token_minter {
    @payer(payer)
    constructor() {}

    function createTokenMint(
        address payer, // payer account
        address mint, // mint account to be created
        address mintAuthority, // mint authority for the mint account
        address freezeAuthority, // freeze authority for the mint account
        address metadata, // metadata account to be created
        uint8 decimals, // decimals for the mint account
        string name, // name for the metadata account
        string symbol, // symbol for the metadata account
        string uri // uri for the metadata account
    ) public {
        // Invoke System Program to create a new account for the mint account and,
        // Invoke Token Program to initialize the mint account
        // Set mint authority, freeze authority, and decimals for the mint account
        SplToken.create_mint(
            payer,            // payer account
            mint,            // mint account
            mintAuthority,   // mint authority
            freezeAuthority, // freeze authority
            decimals         // decimals
        );

        // Invoke Metadata Program to create a new account for the metadata account
        MplMetadata.create_metadata_account(
            metadata, // metadata account
            mint,  // mint account
            mintAuthority, // mint authority
            payer, // payer
            payer, // update authority (of the metadata account)
            name, // name
            symbol, // symbol
            uri // uri (off-chain metadata json)
        );
    }

    function mintTo(address mintAuthority, address tokenAccount, address mint, uint64 amount) public {
        // Mint tokens to the token account
        SplToken.mint_to(
            mint, // mint account
            tokenAccount, // token account
            mintAuthority, // mint authority
            amount // amount
        );
    }
}
