// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

// modules
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {OwnableUnset} from "./custom/OwnableUnset.sol";
import {ERC725XCore} from "./ERC725XCore.sol";
import {ERC725YCore} from "./ERC725YCore.sol";

// constants
import {_INTERFACEID_ERC725X, _INTERFACEID_ERC725Y} from "./constants.sol";

/**
 * @title ERC725 bundle.
 * @author Fabian Vogelsteller <fabian@lukso.network>
 * @dev Bundle ERC725X and ERC725Y together into one smart contract.
 *
 * @custom:warning This implementation does not have by default a `receive()` or `fallback()` function.
 */
contract ERC725 is ERC725XCore, ERC725YCore {
    /**
     * @notice Deploying an ERC725 smart contract and setting address `initialOwner` as the contract owner.
     * @dev Deploy a new ERC725 contract with the provided `initialOwner` as the contract {owner}.
     * @param initialOwner the owner of the contract.
     *
     * @custom:requirements
     * - `initialOwner` CANNOT be the zero address.
     */
    constructor(address initialOwner) payable {
        require(
            initialOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        OwnableUnset._setOwner(initialOwner);
    }

    /**
     * @inheritdoc ERC165
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC725XCore, ERC725YCore) returns (bool) {
        return
            interfaceId == _INTERFACEID_ERC725X ||
            interfaceId == _INTERFACEID_ERC725Y ||
            super.supportsInterface(interfaceId);
    }
}
