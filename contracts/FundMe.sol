// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {PriceConverter} from "contracts/library/priceConverter.sol";

error NotOwner();

contract FundMe{

    using PriceConverter for uint256;
   
    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;

    mapping(address funders => uint256 amountFunders) public addressToAmountFunded;

    address public immutable i_owner;



    constructor () {
        i_owner = msg.sender;
    }

    function fund() public payable{
            //Allow users to send $
            // Have minimum $ sent 5$
            require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enought ETH");
            funders.push(msg.sender);
            addressToAmountFunded[msg.sender] += msg.value;
        
    }

    function withdraw() public{
        for(uint256 funderIndex = 0 ; funderIndex < funders.length; funderIndex++ ){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        //modos de enviar tokens:
        //transfer: o custo máximo de gas é 2300, acima disso da erro
       // payable(msg.sender).transfer((address(this).balance));

        //send: o custo máximo de gas é 2300 e acima disso retorna um bool
       // bool sendSucess = payable(msg.sender).send((address(this).balance));
       // require(sendSucess, "Send failed");
        //call: 
        (bool callSucess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess, "Call failed");
        revert();
    }

    modifier onlyOwner() {
        //require(msg.sender == i_owner, "Must be owner!");
        if(msg.sender != i_owner) {revert NotOwner();}
        _;
    }


    //What happens if someone sends is contract ETH without calling the fund function?

    //receive() Receber
    receive() external payable {
        fund();
     }
     
    //fallback()
    fallback() external payable {
        fund();
     }



}