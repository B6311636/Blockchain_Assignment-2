// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
pragma experimental ABIEncoderV2;

contract ProofOfBocchi {  

  mapping (bytes32 => bool) private listBocchi;

    struct BocchiMetadata{
        string times;
        string cards;
        string owners;
    }
    BocchiMetadata[] bocchi;
  //---events---
  event NameAdded(
    address from,   
    string text,
    bytes32 hash,
    string time,
    string owner

  );
  
  event RegistrationError(
    address from,
    string text,
    string reason
  );

  // store the proof for a student in the contract state
  function recordProof(bytes32 proof) private {
    listBocchi[proof] = true;
  }
  
  function registration(string memory name ,string memory owner ,string memory time) public payable {

    if(keccak256(bytes(name)) == keccak256(bytes("Gotoh Hitori"))) {
        if (msg.value != 0.001 ether) {
            //---fire the event---
            emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.001 ether");
            //---refund back to the sender---
            payable(msg.sender).transfer(msg.value);
            //---exit the function---
            return;
        } 

    }else if(keccak256(bytes(name)) == keccak256(bytes("Kita Ikuyo"))){
        if (msg.value != 0.002 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.002 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }     

    }else if(keccak256(bytes(name)) == keccak256(bytes("Ijichi Nijika"))){
        if (msg.value != 0.003 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.003 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }     

    }else if(keccak256(bytes(name)) == keccak256(bytes("Yamada Ryo"))){
        if (msg.value != 0.004 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.003 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }     

    }else if(keccak256(bytes(name)) == keccak256(bytes("Ikuyo SSR"))){
        if (msg.value != 0.005 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amount of Ether. You should pay 0.005 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }

    }else{
        emit RegistrationError(msg.sender, name, "Card not found, please contact seller");
        payable(msg.sender).transfer(msg.value);
        return;
    }

    recordProof(hashing(name));

    bocchi.push(BocchiMetadata(time,name,owner));

    emit NameAdded(msg.sender, name, hashing(name), time, owner);  
  }
  
  // SHA256 for Integrity
  function hashing(string memory name) private 
  pure returns (bytes32) {
    return sha256(bytes(name));
  }
  
  // check name of student in this class
  function checkName(string memory name) public 
  view returns (bool) {
    return listBocchi[hashing(name)];
  }

  function getBocchiMetadata() public view returns(BocchiMetadata[] memory){
    return bocchi;
  }
}