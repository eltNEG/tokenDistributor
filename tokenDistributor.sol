pragma solidity 0.4.18;

//// Contract to distribute token by eltneg (t.me/eltneg)


contract Token {
    uint256 public decimals;
    function balanceOf(address who) public constant returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
}

contract Distributor {
    address public owner;
    Token public currentToken;
    uint256 public tokenDecimal;
    
    modifier onlyOwner() {
      require(msg.sender == owner);
      _;
    }
    
    function Distributor () public {
        owner = msg.sender;
    }
    
    function distributeToken (address[] addresses, uint256[] value ) public onlyOwner returns(uint number) {
        for ( uint256 i = 0; i < addresses.length; i++) {
            currentToken.transfer(addresses[i], value[i] * 10 ** tokenDecimal);
        }
        return i;
    }
    
    function airdropToken (address[] addresses, uint256 value ) public onlyOwner returns(uint number) {
        for ( uint256 i = 0; i < addresses.length; i++) {
            currentToken.transfer(addresses[i], value * 10 ** tokenDecimal);
        }
        return i;
    }
    
    function setToken (address newToken) public onlyOwner {
        currentToken = Token(newToken);
        tokenDecimal = currentToken.decimals();
    }
    
    function withdrawToken (address _to) public onlyOwner returns(bool success) {
        currentToken.transfer(_to, currentToken.balanceOf(this));
        return true;
    }
    
    function withdrawToken (address _to, uint256 value) public onlyOwner returns(bool success) {
        currentToken.transfer(_to, value * 10 ** tokenDecimal);
        return true;
    }
    
    function getTokenBalance () public view returns (uint256 balance) {
        return currentToken.balanceOf(this) / 10 ** tokenDecimal;
    }
}
