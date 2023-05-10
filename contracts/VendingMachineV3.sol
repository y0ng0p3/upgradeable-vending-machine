// SPX-Licence-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMacineV3 is Initializable {
    uint public numSodas;
    address public owner;
    mapping (address => uint) userSodas;

    function initialize(uint _numSodas)  public initializer {
        numSodas = _numSodas;
        owner = msg.sender;
    }
    
    function purchaseSoda() public payable {
        require(msg.value >= 1000 wei, "You must pay 1000 wei for a soda!");
        require(numSodas > 0, "No soda to be purchased!");
        numSodas--;
        userSodas[msg.sender]++;
    }

    function withdrawProfits() public onlyOwner {
        require(address(this).balance > 0, "Profits must be greater than 0 in order to withdraw.");
        (bool sent, ) = owner.call{ value: address(this).balance }("");
        require(sent, "Failed to send profits.");
    }

    function addSodas(uint _newSodas) public {
        numSodas += _newSodas;
    }

    function setNewOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }
}
