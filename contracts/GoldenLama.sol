// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract GoldenLama {

    struct ItemInfo {
        uint256 purchaseType;
        uint256 price;
        uint256 dailyProfit;
    }
    
    struct LevelOneItems {
        uint256 countOfSand;
        uint256 countOfSky;
        uint256 countOfSea;
        uint256 countOfCloud;
        uint256 countOfSun;
        uint256 countOfGull;
    }

    struct LevelTwoItems {
        uint256 countOfPalm;
        uint256 countOfCoconuts;
        uint256 countOfGoldFish;
        uint256 countOfCrab;
        uint256 countOfShells;
        uint256 countOfColoredStones;
    }
    
    struct LevelThreeItems {
        uint256 countOfSandCastel;
        uint256 countOfChaiseLounge;
        uint256 countOfSuncreen;
        uint256 countOfBasket;
        uint256 countOfTowel;
        uint256 countOfUmbrella;
    }
    
    struct LevelFourItems {
        uint256 countOfBoa;
        uint256 countOfSunglasses;
        uint256 countOfBaseballCap;
        uint256 countOfSwimsuitTop;
        uint256 countOfSwimsuitBriefs;
        uint256 countOfCrocs;
    }
    
    struct LevelFiveItems {
        uint256 countOfFlamingoRing;
        uint256 countOfCoctail;
        uint256 countOfGoldenColor;
        uint256 countOfSmartWatch;
        uint256 countOfSmartphone;
        uint256 countOfYacht;
    }

    struct UserInfo {
        uint256 userId;
        uint256 refId;
        uint256 dateOfEntry;
        uint256 profitDept;
        uint256 balanceOfCocktail;
        uint256 balanceOfCoin;
    }

    uint8 private constant SAND_PURCHASE_TYPE = 0;
    uint8 private constant SKY_PURCHASE_TYPE = 1;
    uint8 private constant SEA_PURCHASE_TYPE = 2;
    uint8 private constant CLOUD_PURCHASE_TYPE = 3;
    uint8 private constant SUN_PURCHASE_TYPE = 4;
    uint8 private constant GULL_PURCHASE_TYPE = 5;
    uint8 private constant PALM_PURCHASE_TYPE = 6;
    uint8 private constant COCONUTS_PURCHASE_TYPE = 7;
    uint8 private constant GOLD_FISH_PURCHASE_TYPE = 8;
    uint8 private constant CRAB_PURCHASE_TYPE = 9;
    uint8 private constant SHELLS_PURCHASE_TYPE = 10;
    uint8 private constant COLORED_STONES_PURCHASE_TYPE = 11;
    uint8 private constant SAND_CASTEL_PURCHASE_TYPE = 12;
    uint8 private constant CHAISE_LOUNGE_PURCHASE_TYPE = 13;
    uint8 private constant SUNSCREEN_PURCHASE_TYPE = 14;
    uint8 private constant BASKET_PURCHASE_TYPE = 15;
    uint8 private constant TOWEL_PURCHASE_TYPE = 16;
    uint8 private constant UMBRELLA_PURCHASE_TYPE = 17;
    uint8 private constant BOA_PURCHASE_TYPE = 18;
    uint8 private constant SUNGLASSES_PURCHASE_TYPE = 19;
    uint8 private constant BASEBALL_CAP_PURCHASE_TYPE = 20;
    uint8 private constant SWIMSUIT_TOP_PURCHASE_TYPE = 21;
    uint8 private constant SWIMSUIT_BRIEFS_PURCHASE_TYPE = 22;
    uint8 private constant CROCS_PURCHASE_TYPE = 23;
    uint8 private constant FLAMINGO_RING_PURCHASE_TYPE = 24;
    uint8 private constant COCKTAIL_PURCHASE_TYPE = 25;
    uint8 private constant GOLDEN_COLOR_PURCHASE_TYPE = 26;
    uint8 private constant SMART_WATCH_PURCHASE_TYPE = 27;
    uint8 private constant SMARTPHONE_PURCHASE_TYPE = 28;
    uint8 private constant YACHT_PURCHASE_TYPE = 29;
    uint8 private constant REFERRER_PROCENT_OF_COCKTAILS = 7;
    uint8 private constant REFERRER_PROCENT_OF_COIN = 7;

    ItemInfo[30] public itemInfo;
    uint256 public usersCount;
    address bankAddress;
    address owner;
    uint256 public priceOfCocktail;
    uint256 public priceOfCoins;
    uint256 public priceOfGoldenCoin;
    mapping(address => UserInfo) userInfo;
    mapping(address => LevelOneItems) levelOneItems;
    mapping(address => LevelTwoItems) levelTwoItems;
    mapping(address => LevelThreeItems) levelThreeItems;
    mapping(address => LevelFourItems) levelFourItems;
    mapping(address => LevelFiveItems) levelFiveItems;
    mapping(address => address) public addressToHisReferrer; // Referrer is higher in the tree
    mapping(uint256 => address) public idToHisAddress; // ID is for referral system, user can invite other users by his id
    mapping(address => bool) public isAdmin;

    //events
    event BankAddressSet(address indexed wallet, uint256 indexed timestamp);
    event CocktailBought(address indexed buyer, uint256 indexed count, uint256 indexed timestamp);
    event CocktailExchange(address indexed user, uint256 indexed count, uint256 indexed timestamp);
    event ReferralsCountBonus(address indexed user, uint256 indexed bonusAmount, uint256 indexed timestamp);
    event BoughtTicketsCountBonus(address indexed user, uint256 indexed bonusAmount, uint256 indexed timestamp);
    event SoldTicketsCountBonus(address indexed user, uint256 indexed bonusAmount, uint256 indexed timestamp);
    event TicketNumberSet(uint256 indexed ticketNumber, uint256 indexed timestamp);
    event TicketPriceSet(uint256 indexed ticketPrice, uint256 indexed timestamp);
    event MonthlyJackpotAddressSet(address indexed monthlyJackpot, uint256 indexed timestamp);
    event TicketNFTAddressSet(address indexed NFTAddress, uint256 indexed timestamp);
    event StableCoinAddressSet(address indexed NFTAddress, uint256 indexed timestamp);
    event NewCycleStarted(address indexed caller, uint256 cycleCount, uint256 indexed timestamp);
    event WinnersRewarded(address indexed caller, uint256 indexed timestamp);
    event MonthlyJackpotExecuted(address indexed winner, uint256 indexed newJackpotStartingTime);

    modifier onlyOwner {
        require(msg.sender == owner, "GoldenLama:: Caller is not the owner!");
        _;
    }

    modifier onlyAdmin(){
        require(isAdmin[msg.sender] || msg.sender == owner, "GoldenLama:: This function can be called only by admins");
        _;
    }

    constructor() {
        owner = msg.sender;
        usersCount = 1;
    }

    receive() external payable {}

    fallback() external payable {}

    function addUserToMlm(address _user, uint256 _refId) external onlyAdmin {
        require(!(addressToHisReferrer[_user] != address(0) && idToHisAddress[_refId] != addressToHisReferrer[_user]),"GoldenLama:: your referrer is already set and it is another user"); //checking refid
        require(_refId < usersCount, "GoldenLama:: Please provide right ID!");

        userInfo[_user].refId = _refId;
        userInfo[_user].userId = usersCount;
        idToHisAddress[usersCount] = _user;
        ++usersCount;
    }

    function setBankAddress(address _bankAddress) external onlyOwner {
        bankAddress = _bankAddress;
        emit BankAddressSet(_bankAddress, block.timestamp);
    }

    function buyCocktail(uint256 _count) external payable {
        require(_count > 0, "GoldenLama:: Cocktails count to buy should be greater than 0!");
        require((msg.sender).balance >= msg.value, "GoldenLama:: Insufficient user balance!");
        require(msg.value >= (_count * priceOfCocktail), "GoldenLama:: Insufficient funds for buying cocktails!");
        uint256 amountToReturn = msg.value - (_count * priceOfCocktail); 
        uint256 amountToTransfer = msg.value - amountToReturn;

        if(amountToReturn > 0) {
            payable(msg.sender).transfer(amountToReturn);
        }
        payable(owner).transfer(amountToTransfer / 10);
        payable(bankAddress).transfer(amountToTransfer * 9 / 10);

        userInfo[msg.sender].balanceOfCocktail += _count;
        emit CocktailBought(msg.sender, _count, block.timestamp);
    }

    function exchangeCocktailsWithCoins(uint256 _count) external {
        require(_count > 0,"GoldenLama:: Cocktails count to exchange should be greater than 0!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count, "GoldenLama:: Insufficient balance of cocktails!");
        userInfo[msg.sender].balanceOfCocktail -= _count;
        userInfo[msg.sender].balanceOfCoin += _count * 100;
        emit CocktailExchange(msg.sender, _count, block.timestamp);
    }

    // this function is not working as I want
    function sellCois(uint256 _count) external {
        require(userInfo[msg.sender].balanceOfCoin >= _count, "GoldenLama:: Insufficient balance of cocktails!");
        userInfo[msg.sender].balanceOfCoin -= _count;
        uint256 amountToTransfer = _count * priceOfCoins;
        payable(msg.sender).transfer(amountToTransfer); 
    }

    /**
    * @notice Function - setAdminStatus
    * @dev Sets Admin status.
    * @param _admin Address of Admin.
    * @param _status Boolean variable for enabling or disabling Admin.
    * @dev Only the contract owner can execute this function.
    */
    function setAdminStatus(address _admin, bool _status) external onlyOwner{
        isAdmin[_admin] = _status;
    }

    function setSuperBundles(ItemInfo[30] calldata _items) external onlyOwner {
        itemInfo = _items;
    }

    function purchaseLevelOneItems(uint8 _itemType, uint256 _count) external {
        require(_count > 0, "GoldenLama:: You cann't buy 0 item!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count * itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        _validateLevelOneItemsTypes(_itemType);
        if(_itemType == 0){
            levelOneItems[msg.sender].countOfSand += _count;
        } else if(_itemType == 1) {
            require(levelOneItems[msg.sender].countOfSand > 0, "GoldenLama:: You must buy the previous one!");
            levelOneItems[msg.sender].countOfSky += _count;
        } else if(_itemType == 2) {
            require(levelOneItems[msg.sender].countOfSand > 0 && levelOneItems[msg.sender].countOfSky > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItems[msg.sender].countOfSea += _count;
        } else if(_itemType == 3) {
            require(levelOneItems[msg.sender].countOfSand > 0 && levelOneItems[msg.sender].countOfSky > 0 && levelOneItems[msg.sender].countOfSea > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItems[msg.sender].countOfCloud += _count;
        } else if(_itemType == 4) {
            require(levelOneItems[msg.sender].countOfSand > 0 && levelOneItems[msg.sender].countOfSky > 0 && levelOneItems[msg.sender].countOfSea > 0 && levelOneItems[msg.sender].countOfCloud > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItems[msg.sender].countOfSun += _count;
        } else {
            require(levelOneItems[msg.sender].countOfSand > 0 && levelOneItems[msg.sender].countOfSky > 0 && levelOneItems[msg.sender].countOfSea > 0 && levelOneItems[msg.sender].countOfCloud > 0 && levelOneItems[msg.sender].countOfSun > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItems[msg.sender].countOfGull += _count;
        }
    }

    function purchaseLevelTwoItems(uint8 _itemType, uint256 _count) external {
        require(_count > 0, "You cann't buy 0 item!");
        _validateLevelTwoItemsTypes(_itemType);
    }

    function purchaseLevelThreeItems(uint8 _itemType, uint256 _count) external {
        require(_count > 0, "You cann't buy 0 item!");
        _validateLevelThreeItemsTypes(_itemType);
    }

    function purchaseLevelFourItems(uint8 _itemType, uint256 _count) external {
        require(_count > 0, "You cann't buy 0 item!");
        _validateLevelFourItemsTypes(_itemType);
    }

    function purchaseLevelFiveItems(uint8 _itemType, uint256 _count) external {
        require(_count > 0, "You cann't buy 0 item!");
        _validateLevelFiveItemsTypes(_itemType);
    }

    function _validateLevelOneItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == SAND_PURCHASE_TYPE || 
            _itemType == SEA_PURCHASE_TYPE || 
            _itemType == SKY_PURCHASE_TYPE ||
            _itemType == CLOUD_PURCHASE_TYPE ||
            _itemType == SUN_PURCHASE_TYPE ||
            _itemType == GULL_PURCHASE_TYPE
        );
    }
    
    function _validateLevelTwoItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == PALM_PURCHASE_TYPE || 
            _itemType == COCONUTS_PURCHASE_TYPE || 
            _itemType == GOLD_FISH_PURCHASE_TYPE ||
            _itemType == CRAB_PURCHASE_TYPE ||
            _itemType == SHELLS_PURCHASE_TYPE ||
            _itemType == COLORED_STONES_PURCHASE_TYPE
        );
    }

    function _validateLevelThreeItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == SAND_CASTEL_PURCHASE_TYPE || 
            _itemType == CHAISE_LOUNGE_PURCHASE_TYPE || 
            _itemType == SUNSCREEN_PURCHASE_TYPE ||
            _itemType == BASKET_PURCHASE_TYPE ||
            _itemType == TOWEL_PURCHASE_TYPE ||
            _itemType == UMBRELLA_PURCHASE_TYPE
        );
    }

    function _validateLevelFourItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == BOA_PURCHASE_TYPE || 
            _itemType == SUNGLASSES_PURCHASE_TYPE || 
            _itemType == BASEBALL_CAP_PURCHASE_TYPE ||
            _itemType == SWIMSUIT_TOP_PURCHASE_TYPE ||
            _itemType == SWIMSUIT_BRIEFS_PURCHASE_TYPE ||
            _itemType == CROCS_PURCHASE_TYPE
        );
    }

    function _validateLevelFiveItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == FLAMINGO_RING_PURCHASE_TYPE || 
            _itemType == COCKTAIL_PURCHASE_TYPE || 
            _itemType == GOLDEN_COLOR_PURCHASE_TYPE ||
            _itemType == SMART_WATCH_PURCHASE_TYPE ||
            _itemType == SMARTPHONE_PURCHASE_TYPE ||
            _itemType == YACHT_PURCHASE_TYPE
        );
    }





    
    struct Tower {
        uint256 runes;
        uint256 money;
        uint256 money2;
        uint256 spellLevel;
        uint256 altarLevel;
        uint256 yield;
        uint256 timestamp;
        uint256 hrs;
        uint256 maxHrs;
        address ref;
        uint256 refs;
        uint256 refDeps;
        uint8[8] mages;
    }

    struct Wars {
        uint256 wins;
        uint256 loses;
    }

    struct Arena {
        address player1;
        address player2;
        uint256 runes;
        uint256 timestamp;
        address winner;
        uint256 roll;
    }

    mapping(address => Tower) public towers;
    mapping(address => mapping(uint256 => Arena)) public arenas;
    mapping(address => Wars) public wars;
    mapping(uint256 => address) public waitingArenas;

    uint256 public totalMages;
    uint256 public totalTowers;
    uint256 public totalInvested;
    uint256 public totalWars;

    address public manager1 = 0x395F6B9597c30D5143142379c38940200Bfa72aB;
    address public manager2 = 0xa6B6615A6A3562BaF5FEB52fc86A7D9aAe86d3fE;
    address public defaultRef = 0x23c35894340cb2D881f8022E15C73A5df41aECCF;

    function addRunes(address ref) public payable {
        require(
            msg.sender == tx.origin,
            "Function can only be called by a user account."
        );
        uint256 runes = msg.value / 2e13;
        require(runes > 0, "Zero runes");
        address user = msg.sender;
        totalInvested += msg.value;
        if (towers[user].timestamp == 0) {
            totalTowers++;
            ref = towers[ref].timestamp == 0 ? defaultRef : ref;
            towers[ref].refs++;
            towers[user].ref = ref;
            towers[user].maxHrs = 24;
            towers[user].timestamp = block.timestamp;
        }

        ref = towers[user].ref;
        towers[ref].runes += (runes * 7) / 100;
        towers[ref].money += (runes * 100 * 3) / 100;
        towers[ref].refDeps += runes;

        // Owner FEE
        uint256 runesFee = (runes * 3) / 100;
        uint256 moneyFee = (msg.value * 5) / 100;

        towers[manager1].runes += runesFee / 2;
        payable(manager1).transfer(moneyFee / 2);

        towers[manager2].runes += runesFee / 2;
        payable(manager2).transfer(moneyFee / 2);

        towers[user].runes += runes;
    }

    function withdrawMoney(uint256 amount) public {
        require(
            msg.sender == tx.origin,
            "Function can only be called by a user account."
        );
        require(amount >= 100, "Invalid amount");

        address user = msg.sender;
        uint256 real = amount * 2e11;

        // Perform all state changes before any external interaction
        towers[user].money -= amount;

        // Only transfer funds if the contract has enough balance
        if (address(this).balance >= real) {
            (bool success, ) = payable(user).call{value: real}("");
            require(success, "Transfer failed.");
        }
    }

    function collectMoney() public {
        address user = msg.sender;
        syncTower(user);
        towers[user].hrs = 0;
        towers[user].money += towers[user].money2;
        towers[user].money2 = 0;
    }

    function swapMoney(uint256 amount) public {
        require(amount >= 100, "Invalid amount");
        address user = msg.sender;
        towers[user].money -= amount;
        towers[user].runes += amount / 100;
    }

    function upgradeTower(uint256 floorId) public {
        require(floorId < 8, "Max 8 floors");
        address user = msg.sender;
        syncTower(user);
        towers[user].mages[floorId]++;
        totalMages++;
        uint256 mages = towers[user].mages[floorId];
        towers[user].runes -= getUpgradeTowerPrice(floorId, mages);
        towers[user].yield += getTowerYield(floorId, mages);
    }

    function upgradeAltar() public {
        address user = msg.sender;
        syncTower(user);
        towers[user].runes -= getUpgradeAltarPrice(towers[user].altarLevel);
        towers[user].maxHrs = getAltarHours(towers[user].altarLevel);
        towers[user].altarLevel += 1;
    }

    function upgradeSpells() public {
        address user = msg.sender;
        syncTower(user);

        towers[user].runes -= getUpgradeSpellPrice(towers[user].spellLevel);
        towers[user].spellLevel += 1;
    }

    function sellTower() public {
        collectMoney();
        address user = msg.sender;
        uint8[8] memory mages = towers[user].mages;
        totalMages -=
            mages[0] +
            mages[1] +
            mages[2] +
            mages[3] +
            mages[4] +
            mages[5] +
            mages[6] +
            mages[7];
        towers[user].money += towers[user].yield * 24 * 14;
        towers[user].mages = [0, 0, 0, 0, 0, 0, 0, 0];
        towers[user].spellLevel = 0;
        towers[user].altarLevel = 0;
        towers[user].maxHrs = 0;
        towers[user].yield = 0;
    }

    function getMages(address addr) public view returns (uint8[8] memory) {
        return towers[addr].mages;
    }

    function syncTower(address user) internal {
        require(towers[user].timestamp > 0, "User is not registered");
        if (towers[user].yield > 0) {
            uint256 hrs = block.timestamp /
                3600 -
                towers[user].timestamp /
                3600;

            if (hrs + towers[user].hrs > towers[user].maxHrs) {
                hrs = towers[user].maxHrs - towers[user].hrs;
            }

            uint256 money = hrs * towers[user].yield;
            uint256 bonusPercent = getLeaderBonusPercent(towers[user].refs);

            if (towers[user].spellLevel > 0) {
                bonusPercent += getSpellYield(towers[user].spellLevel - 1);
            }

            money += (money * bonusPercent) / 100 / 100;

            towers[user].money2 += money;
            towers[user].hrs += hrs;
        }

        towers[user].timestamp = block.timestamp;
    }

    function getUpgradeTowerPrice(uint256 floorId, uint256 mageId)
        internal
        pure
        returns (uint256)
    {
        if (mageId == 1)
            return
                [500, 1500, 4500, 13500, 40500, 120000, 365000, 1000000][
                    floorId
                ];
        if (mageId == 2)
            return
                [625, 1800, 5600, 16800, 50600, 150000, 456000, 1200000][
                    floorId
                ];
        if (mageId == 3)
            return
                [780, 2300, 7000, 21000, 63000, 187000, 570000, 1560000][
                    floorId
                ];
        if (mageId == 4)
            return
                [970, 3000, 8700, 26000, 79000, 235000, 713000, 2000000][
                    floorId
                ];
        if (mageId == 5)
            return
                [1200, 3600, 11000, 33000, 98000, 293000, 890000, 2500000][
                    floorId
                ];
        revert("Incorrect mageId");
    }

    function getUpgradeSpellPrice(uint256 level)
        internal
        pure
        returns (uint256)
    {
        return [10000, 15000, 20000, 25000, 30000][level];
    }

    function getUpgradeAltarPrice(uint256 level)
        internal
        pure
        returns (uint256)
    {
        return [2000, 6000, 10000, 12000][level];
    }

    function getTowerYield(uint256 floorId, uint256 mageId)
        internal
        pure
        returns (uint256)
    {
        if (mageId == 1)
            return [41, 130, 399, 1220, 3750, 11400, 36200, 104000][floorId];
        if (mageId == 2)
            return [52, 157, 498, 1530, 4700, 14300, 45500, 126500][floorId];
        if (mageId == 3)
            return [65, 201, 625, 1920, 5900, 17900, 57200, 167000][floorId];
        if (mageId == 4)
            return [82, 264, 780, 2380, 7400, 22700, 72500, 216500][floorId];
        if (mageId == 5)
            return [103, 318, 995, 3050, 9300, 28700, 91500, 275000][floorId];
        revert("Incorrect mageId");
    }

    function getLeaderBonusPercent(uint256 refs)
        internal
        pure
        returns (uint256)
    {
        if (refs >= 100) return 100;
        if (refs >= 50) return 50;
        return 0;
    }

    function getSpellYield(uint256 level) internal pure returns (uint256) {
        return [10, 20, 30, 40, 50][level];
    }

    function getAltarHours(uint256 level) internal pure returns (uint256) {
        return [30, 36, 42, 48][level];
    }

    // Arena:
    function createArena(uint256 arenaType) public {
        require(arenaType < 3, "Incorrect type");

        address arenaCreator = waitingArenas[arenaType];
        require(msg.sender != arenaCreator, "You are already in arena");

        if (arenaCreator == address(0)) {
            _createArena(arenaType);
        } else {
            _joinArena(arenaType, arenaCreator);
            _fightArena(arenaType, arenaCreator);
        }
    }

    function getArenaType(uint256 arenaType) internal pure returns (uint256) {
        return [1000, 10000, 50000][arenaType];
    }

    function _randomNumber() internal view returns (uint256) {
        uint256 randomnumber = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp +
                        block.difficulty +
                        ((
                            uint256(keccak256(abi.encodePacked(block.coinbase)))
                        ) / (block.timestamp)) +
                        block.gaslimit +
                        ((uint256(keccak256(abi.encodePacked(msg.sender)))) /
                            (block.timestamp)) +
                        block.number
                )
            )
        );

        return randomnumber % 100;
    }

    function _createArena(uint256 arenaType) internal {
        arenas[msg.sender][arenaType].timestamp = block.timestamp;
        arenas[msg.sender][arenaType].player1 = msg.sender;
        arenas[msg.sender][arenaType].player2 = address(0);
        arenas[msg.sender][arenaType].winner = address(0);
        arenas[msg.sender][arenaType].runes = getArenaType(arenaType);
        arenas[msg.sender][arenaType].roll = 0;
        towers[msg.sender].runes -= arenas[msg.sender][arenaType].runes;
        waitingArenas[arenaType] = msg.sender;
    }

    function _joinArena(uint256 arenaType, address arenaCreator) internal {
        arenas[arenaCreator][arenaType].timestamp = block.timestamp;
        arenas[arenaCreator][arenaType].player2 = msg.sender;
        towers[msg.sender].runes -= arenas[arenaCreator][arenaType].runes;
        waitingArenas[arenaType] = address(0);
    }

    function _fightArena(uint256 arenaType, address arenaCreator) internal {
        uint256 random = _randomNumber();
        uint256 wAmount = arenas[arenaCreator][arenaType].runes * 2;
        uint256 fee = (wAmount * 10) / 100;

        address winner = random < 50
            ? arenas[arenaCreator][arenaType].player1
            : arenas[arenaCreator][arenaType].player2;
        address loser = random >= 50
            ? arenas[arenaCreator][arenaType].player1
            : arenas[arenaCreator][arenaType].player2;

        towers[winner].runes += wAmount - fee;
        arenas[arenaCreator][arenaType].winner = winner;
        arenas[arenaCreator][arenaType].roll = random;

        wars[winner].wins++;
        wars[loser].loses++;
        totalWars++;

        towers[manager1].runes += fee / 2;
        towers[manager2].runes += fee / 2;
    }
}