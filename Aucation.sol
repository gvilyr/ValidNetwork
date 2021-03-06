pragma solidity ^0.4.19;
contract Aucation{
	address public manager;
	address public seller;
	uint public latestBid;
	address public latestBidder;
	constructor() public {
		manager = msg.sender;
	}
	function auction(uint bid) public{
		latestBid = bid * 1 ether;
		seller = msg.sender;
	}
	function bid() public payable{
		require(msg.value > latestBid);
		if(latestBid != 0x0){
			latestBidder.transfer(latestBid);
		}
		latestBidder = msg.sender;
		latestBid = msg.value;
	}
	function finishAuction() restricted public{
		seller.transfer(address(this).balance);
	}
	modifier restricted(){
		require(msg.sender == manager);
		_;
	}
}	
