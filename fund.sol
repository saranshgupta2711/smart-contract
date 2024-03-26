
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe{


    address public owner;                        //variable owner
      constructor() {
        owner=msg.sender;                        //declaring owner
      }

      modifier owne{                                 //custom modifier used to check owner in every function
        require(owner==msg.sender,"you dont owe this");
        _;
      }
      uint256 public maxWei=1e10;    
      mapping(address => uint) public adv; 
      address [] public funder;
      
      function fund() public payable{                               //payment function
          require (msg.value <= maxWei,"Dont fulfill the minimum");
          address _id=msg.sender;
          owner=msg.sender;
           adv[_id]+=msg.value*1e18;                               // store the address with value in adv mapping
           uint flag=0;
           for(uint8 i=0; i<funder.length; i++){                  //will loop through all and check whether funder is already present inside
            if(funder[i]==msg.sender) flag=1;                      //funders array if not then add
           }
           if(flag==0) funder.push(msg.sender);
      }
     
      function withdraw() public owne{                                //reverting all the transact till performed
        for(uint256 i=0; i<funder.length; i=i+1){
          address fundername=funder[i];
          adv[fundername]=0;
        }

        funder=new address[](0);
            payable(msg.sender).transfer(address(this).balance);
      }
}
