// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {PriceConverter} from "contracts/library/priceConverter.sol";

contract FundMe{

    using PriceConverter for uint256;
   
    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address funders => uint256 amountFunders) public addressToAmountFunded;

    function fun() public payable{
            //Allow users to send $
            // Have minimum $ sent 5$
            require(msg.value.getConversionRate() >= minimumUsd, "didn't send enought ETH");
            funders.push(msg.sender);
            addressToAmountFunded[msg.sender] += msg.value;
        
    }

    function withdraw() public{
        for(uint256 funderIndex = 0 ; funderIndex < funders.length; funderIndex++ ){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
    }



}