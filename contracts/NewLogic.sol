// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract GoldenLama {

    struct ItemInfo {
        uint256 purchaseType;
        uint256 price;
        uint256 dailyProfit;
    }

    struct UserInfo {
        uint256 userId;
        uint256 refId;
        uint256 profitDept;
        uint256 balanceOfCocktail;
        uint256 balanceOfCoin;
    }
    
    struct LevelOneItemInfo {
        uint256 timestampOfSand;
        uint256 timestampOfSky;
        uint256 timestampOfSea;
        uint256 timestampOfCloud;
        uint256 timestampOfSun;
        uint256 timestampOfGull;
        bool allItemsBought;
    }

    struct LevelTwoItemInfo {
        uint256 timestampOfPalm;
        uint256 timestampOfCoconuts;
        uint256 timestampOfGoldFish;
        uint256 timestampOfCrab;
        uint256 timestampOfShells;
        uint256 timestampOfColoredStones;
        bool allItemsBought;
    }
    
    struct LevelThreeItemInfo {
        uint256 timestampOfSandCastel;
        uint256 timestampOfChaiseLounge;
        uint256 timestampOfTowel;
        uint256 timestampOfSuncreen;
        uint256 timestampOfBasket;
        uint256 timestampOfUmbrella;
        bool allItemsBought;    
    }
    
    struct LevelFourItemInfo {
        uint256 timestampOfBoa;
        uint256 timestampOfSunglasses;
        uint256 timestampOfBaseballCap;
        uint256 timestampOfSwimsuitTop;
        uint256 timestampOfSwimsuitBriefs;
        uint256 timestampOfCrocs;
        bool allItemsBought;
    }
    
    struct LevelFiveItemInfo {
        uint256 timestampOfFlamingoRing;
        uint256 timestampOfDrink;
        uint256 timestampOfGoldenColor;
        uint256 timestampOfSmartWatch;
        uint256 timestampOfSmartphone;
        uint256 timestampOfYacht;
    }

//     uint8 private constant SAND_PURCHASE_TYPE = 0;
//     uint8 private constant SKY_PURCHASE_TYPE = 1;
//     uint8 private constant SEA_PURCHASE_TYPE = 2;
//     uint8 private constant CLOUD_PURCHASE_TYPE = 3;
//     uint8 private constant SUN_PURCHASE_TYPE = 4;
//     uint8 private constant GULL_PURCHASE_TYPE = 5;
//     uint8 private constant PALM_PURCHASE_TYPE = 6;
//     uint8 private constant COCONUTS_PURCHASE_TYPE = 7;
//     uint8 private constant GOLD_FISH_PURCHASE_TYPE = 8;
//     uint8 private constant CRAB_PURCHASE_TYPE = 9;
//     uint8 private constant SHELLS_PURCHASE_TYPE = 10;
//     uint8 private constant COLORED_STONES_PURCHASE_TYPE = 11;
//     uint8 private constant SAND_CASTEL_PURCHASE_TYPE = 12;
//     uint8 private constant CHAISE_LOUNGE_PURCHASE_TYPE = 13;
//     uint8 private constant TOWEL_PURCHASE_TYPE = 14;
//     uint8 private constant SUNSCREEN_PURCHASE_TYPE = 15;
//     uint8 private constant BASKET_PURCHASE_TYPE = 16;
//     uint8 private constant UMBRELLA_PURCHASE_TYPE = 17;
//     uint8 private constant BOA_PURCHASE_TYPE = 18;
//     uint8 private constant SUNGLASSES_PURCHASE_TYPE = 19;
//     uint8 private constant BASEBALL_CAP_PURCHASE_TYPE = 20;
//     uint8 private constant SWIMSUIT_TOP_PURCHASE_TYPE = 21;
//     uint8 private constant SWIMSUIT_BRIEFS_PURCHASE_TYPE = 22;
//     uint8 private constant CROCS_PURCHASE_TYPE = 23;
//     uint8 private constant FLAMINGO_RING_PURCHASE_TYPE = 24;
//     uint8 private constant DRINK_PURCHASE_TYPE = 25;
//     uint8 private constant GOLDEN_COLOR_PURCHASE_TYPE = 26;
//     uint8 private constant SMART_WATCH_PURCHASE_TYPE = 27;
//     uint8 private constant SMARTPHONE_PURCHASE_TYPE = 28;
//     uint8 private constant YACHT_PURCHASE_TYPE = 29;
    uint64 private constant PRICE_OF_COCKTAIL = 30000000000000;
    uint64 private constant PRICE_OF_COIN = 300000000000;

    address public owner;
    uint256 public usersCount;
    uint256 public startTimestamp;
    ItemInfo[30] public itemInfo;
    mapping(address => LevelOneItemInfo) public levelOneItemInfo;
    mapping(address => LevelTwoItemInfo) public levelTwoItemInfo;
    mapping(address => LevelThreeItemInfo) public levelThreeItemInfo;
    mapping(address => LevelFourItemInfo) public levelFourItemInfo;
    mapping(address => LevelFiveItemInfo) public levelFiveItemInfo;
    mapping(address => address) public addressToHisReferrer; 
    mapping(uint256 => address) public idToHisAddress; 
    mapping(address => UserInfo) public userInfo;
    mapping(address => bool) public isAdmin;

    //events
    event CocktailBought(address indexed buyer, uint256 indexed count, uint256 indexed timestamp);
    event CocktailSwap(address indexed user, uint256 indexed count, uint256 indexed timestamp);
    event LevelOneItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    event LevelTwoItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    event LevelThreeItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    event LevelFourItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    event LevelFiveItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);

    modifier onlyAdmin(){
        require(isAdmin[msg.sender] || msg.sender == owner, "GoldenLama:: This function can be called only by admins");
        _;
    }

    constructor() {
        owner = msg.sender;
        startTimestamp = block.timestamp;
        usersCount = 1;
    }

    receive() external payable {}

    fallback() external payable {}

    function setAdminStatus(address _admin, bool _status) external onlyAdmin{
        isAdmin[_admin] = _status;
    }

    function setItems() external onlyAdmin {
        // ItemInfo memory temp1 = ItemInfo(1, 600, 1181);
        // ItemInfo memory temp2 = ItemInfo(2, 1200, 2396);

        itemInfo[0] = ItemInfo(0, 600, 1181);
        itemInfo[1] = ItemInfo(1, 1200, 2396);
        itemInfo[1] = ItemInfo(1, 1200, 2396);
        itemInfo[1] = ItemInfo(1, 1200, 2396);
        itemInfo[1] = ItemInfo(1, 1200, 2396);
        itemInfo[1] = ItemInfo(1, 1200, 2396);
        itemInfo[1] = ItemInfo(1, 1200, 2396);
        itemInfo[1] = ItemInfo(1, 1200, 2396);
        // ItemInfo[30] = new _itemInfo  [[2,1800,3600],[3,2400,4870],[4,3000,6180],[5,3600,7489],[6,4200,8792],[7,4800,10069],[8,5500,11618],[9,6500,13782],[10,7000,14896],[11,8000,17075],[12,9000,19288],[13,10000,21519],[14,12000,26052],[15,16000,34707],[16,20000,43715],[17,25000,54860],[18,30000,65919],[19,35000,77639],[20,40000,88888],[21,50000,111482],[22,65000,146100],[23,80000,179856],[24,100000,227790],[25,120000,273660],[26,150000,343249],[27,180000,413602],[28,230000,533271],[29,300000,705384]];
    }

    function addUserToMlm(address _user, uint256 _refId) external onlyAdmin {
        require(!(addressToHisReferrer[_user] != address(0) && idToHisAddress[_refId] != addressToHisReferrer[_user]),"GoldenLama:: your referrer is already set and it is another user"); //checking refid
        require(_refId < usersCount, "GoldenLama:: Please provide right ID!");

        userInfo[_user].refId = _refId;
        userInfo[_user].userId = usersCount;
        idToHisAddress[usersCount] = _user;
        ++usersCount;
        address referrer = idToHisAddress[_refId];
        addressToHisReferrer[_user] = referrer;
    }

    function buyCocktail(uint256 _count) external payable {
        require(_count > itemInfo[0].price, "GoldenLama:: Cocktails count to buy should be greater than 600!");
        require((msg.sender).balance >= msg.value, "GoldenLama:: Insufficient user balance!");
        require(msg.value >= (_count * PRICE_OF_COCKTAIL), "GoldenLama:: Insufficient funds for buying cocktails!");
        uint256 amountToReturn = msg.value - (_count * PRICE_OF_COCKTAIL); 
        uint256 amountToTransfer = msg.value - amountToReturn;

        if(amountToReturn > 0) {
            payable(msg.sender).transfer(amountToReturn);
        }
        payable(owner).transfer(amountToTransfer / 10);
        payable(address(this)).transfer(amountToTransfer * 9 / 10);

        userInfo[msg.sender].balanceOfCocktail += _count;

        address referrer = addressToHisReferrer[msg.sender];
        if(referrer != address(0)) {
            uint256 countOfCoctails = amountToTransfer * 7 / 1000 / PRICE_OF_COCKTAIL;
            uint256 countOfCoins = amountToTransfer * 3 / 1000 / PRICE_OF_COIN;
            userInfo[referrer].balanceOfCocktail += countOfCoctails;
            userInfo[referrer].balanceOfCoin += countOfCoins;
        }

        emit CocktailBought(msg.sender, _count, block.timestamp);
    }

    function swapCocktailsWithCoins(uint256 _count) external {
        require(_count > 0,"GoldenLama:: Cocktails count to exchange should be greater than 0!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count, "GoldenLama:: Insufficient balance of cocktails!");
        userInfo[msg.sender].balanceOfCocktail -= _count;
        userInfo[msg.sender].balanceOfCoin += _count * 100;
        emit CocktailSwap(msg.sender, _count, block.timestamp);
    }

    function sellCois(uint256 _count) external {
        require(userInfo[msg.sender].balanceOfCoin >= _count, "GoldenLama:: Insufficient balance of cocktails!");
        userInfo[msg.sender].balanceOfCoin -= _count;
        uint256 amountToTransfer = _count * PRICE_OF_COIN;
        // payable(msg.sender).transfer(amountToTransfer); 

        (bool sent,) = payable(msg.sender).call{value:amountToTransfer}("");
        require(sent , "GoldenLama:: not sent!");
    }

    function purchaselevelOneItem(uint8 _itemType) external {
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buying Level 1 item!");
        _validatelevelOneItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;
        uint256 sandTime = levelOneItemInfo[msg.sender].timestampOfSand;
        uint256 skyTime = levelOneItemInfo[msg.sender].timestampOfSky;
        uint256 seaTime = levelOneItemInfo[msg.sender].timestampOfSea;
        uint256 cloudTime = levelOneItemInfo[msg.sender].timestampOfCloud;
        uint256 sunTime = levelOneItemInfo[msg.sender].timestampOfSun;

        if(_itemType == 0){
            sandTime = block.timestamp;
        } else if(_itemType == 1) {
            require(sandTime > 0, "GoldenLama:: You must buy the previous one!");
            skyTime = block.timestamp;
        } else if(_itemType == 2) {
            require(sandTime > 0 && skyTime > 0, "GoldenLama:: You must buy the previous items!");
            seaTime = block.timestamp;
        } else if(_itemType == 3) {
            require(sandTime > 0 && skyTime > 0 && seaTime > 0, "GoldenLama:: You must buy the previous items!");
            cloudTime = block.timestamp;
        } else if(_itemType == 4) {
            require(sandTime > 0 && skyTime > 0 && seaTime > 0 && cloudTime > 0, "GoldenLama:: You must buy the previous items!");
            sunTime = block.timestamp;
        } else {
            require(sandTime > 0 && skyTime > 0 && seaTime > 0 && cloudTime > 0 && sunTime > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItemInfo[msg.sender].timestampOfGull = block.timestamp;
            levelOneItemInfo[msg.sender].allItemsBought = true;
        }

        emit LevelOneItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelTwoItem(uint8 _itemType) external {
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buying Level 2 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the first line!");
        _validatelevelTwoItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;
        uint256 palmTime = levelTwoItemInfo[msg.sender].timestampOfPalm;
        uint256 coconutTime = levelTwoItemInfo[msg.sender].timestampOfCoconuts;
        uint256 fishTime = levelTwoItemInfo[msg.sender].timestampOfGoldFish;
        uint256 crabTime = levelTwoItemInfo[msg.sender].timestampOfCrab; 
        uint256 shellTime = levelTwoItemInfo[msg.sender].timestampOfShells;

        if(_itemType == 6){
            palmTime = block.timestamp;
        } else if(_itemType == 7) {
            require(palmTime > 0, "GoldenLama:: You must buy the previous one!");
            coconutTime = block.timestamp;
        } else if(_itemType == 8) {
            require(palmTime > 0 && coconutTime > 0, "GoldenLama:: You must buy the previous items!");
            fishTime = block.timestamp;
        } else if(_itemType == 9) {
            require(palmTime > 0 && coconutTime > 0 && fishTime > 0, "GoldenLama:: You must buy the previous items!");
            crabTime = block.timestamp;
        } else if(_itemType == 10) {
            require(palmTime > 0 && coconutTime > 0 && fishTime > 0 && crabTime > 0, "GoldenLama:: You must buy the previous items!");
            shellTime = block.timestamp;
        } else {
            require(palmTime > 0 && coconutTime > 0 && fishTime > 0 && crabTime > 0 && shellTime > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItemInfo[msg.sender].timestampOfColoredStones = block.timestamp;
            levelTwoItemInfo[msg.sender].allItemsBought = true;
        }

        emit LevelTwoItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelThreeItem(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 11 days, "GoldenLama:: Third line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buying Level 3 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");      
        _validatelevelThreeItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;
        uint256 castelTime = levelThreeItemInfo[msg.sender].timestampOfSandCastel;
        uint256 CLTime = levelThreeItemInfo[msg.sender].timestampOfChaiseLounge;
        uint256 towelTime = levelThreeItemInfo[msg.sender].timestampOfTowel;
        uint256 sunscreenTime = levelThreeItemInfo[msg.sender].timestampOfSuncreen;
        uint256 basketTime = levelThreeItemInfo[msg.sender].timestampOfBasket;

        if(_itemType == 12){
            castelTime = block.timestamp;
        } else if(_itemType == 13) {
            require(castelTime > 0, "GoldenLama:: You must buy the previous one!");
            CLTime = block.timestamp;
        } else if(_itemType == 14) {
            require(castelTime > 0 && CLTime > 0, "GoldenLama:: You must buy the previous items!");
            towelTime = block.timestamp;
        } else if(_itemType == 15) {
            require(castelTime > 0 && CLTime > 0 && towelTime > 0, "GoldenLama:: You must buy the previous items!");
            sunscreenTime = block.timestamp;
        } else if(_itemType == 16) {
            require(castelTime > 0 && CLTime > 0 && towelTime > 0 && sunscreenTime > 0, "GoldenLama:: You must buy the previous items!");
            basketTime = block.timestamp;
        } else {
            require(castelTime > 0 && CLTime > 0 && towelTime > 0 && sunscreenTime > 0 && basketTime > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItemInfo[msg.sender].timestampOfUmbrella = block.timestamp;
            levelThreeItemInfo[msg.sender].allItemsBought = true;
        }
        
        emit LevelThreeItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelFourItem(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 21 days, "GoldenLama:: Fourth line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buying Level 4 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true && levelThreeItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");      
        _validatelevelFourItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;
        uint256 boaTime = levelFourItemInfo[msg.sender].timestampOfBoa;
        uint256 sunglassesTime = levelFourItemInfo[msg.sender].timestampOfSunglasses;
        uint256 capTime = levelFourItemInfo[msg.sender].timestampOfBaseballCap;
        uint256 topTime = levelFourItemInfo[msg.sender].timestampOfSwimsuitTop;
        uint256 briefTime = levelFourItemInfo[msg.sender].timestampOfSwimsuitBriefs;

        if(_itemType == 18){
            boaTime = block.timestamp;
        } else if(_itemType == 19) {
            require(boaTime > 0, "GoldenLama:: You must buy the previous one!");
            sunglassesTime = block.timestamp;
        } else if(_itemType == 20) {
            require(boaTime > 0 && sunglassesTime > 0, "GoldenLama:: You must buy the previous items!");
            capTime = block.timestamp;
        } else if(_itemType == 21) {
            require(boaTime > 0 && sunglassesTime > 0 && capTime > 0, "GoldenLama:: You must buy the previous items!");
            topTime = block.timestamp;
        } else if(_itemType == 22) {
            require(boaTime > 0 && sunglassesTime > 0 && capTime > 0 && topTime > 0, "GoldenLama:: You must buy the previous items!");
            briefTime = block.timestamp;
        } else {
            require(boaTime > 0 && sunglassesTime > 0 && capTime > 0 && topTime > 0 && briefTime > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItemInfo[msg.sender].timestampOfCrocs = block.timestamp;
            levelFourItemInfo[msg.sender].allItemsBought = true;
        }

        emit LevelFourItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelFiveItem(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 41 days, "GoldenLama:: Fifth line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buying Level 5 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true && levelThreeItemInfo[msg.sender].allItemsBought == true && levelFourItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");
        _validatelevelFiveItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;
        uint256 ringTime = levelFiveItemInfo[msg.sender].timestampOfFlamingoRing;
        uint256 drinkTime = levelFiveItemInfo[msg.sender].timestampOfDrink;
        uint256 colorTime = levelFiveItemInfo[msg.sender].timestampOfGoldenColor;
        uint256 watchTime = levelFiveItemInfo[msg.sender].timestampOfSmartWatch; 
        uint256 phonetime = levelFiveItemInfo[msg.sender].timestampOfSmartphone;

        if(_itemType == 24){
            ringTime = block.timestamp;
        } else if(_itemType == 25) {
            require(ringTime > 0, "GoldenLama:: You must buy the previous one!");
            drinkTime = block.timestamp;
        } else if(_itemType == 26) {
            require(ringTime > 0 && drinkTime > 0, "GoldenLama:: You must buy the previous items!");
            colorTime = block.timestamp;
        } else if(_itemType == 27) {
            require(ringTime > 0 && drinkTime > 0 && colorTime > 0, "GoldenLama:: You must buy the previous items!");
            watchTime = block.timestamp;
        } else if(_itemType == 28) {
            require(ringTime > 0 && drinkTime > 0 && colorTime > 0 && watchTime > 0, "GoldenLama:: You must buy the previous items!");
            phonetime = block.timestamp;
        } else {
            require(ringTime > 0 && drinkTime > 0 && colorTime > 0 && watchTime > 0 && phonetime > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItemInfo[msg.sender].timestampOfYacht = block.timestamp;
        }

        emit LevelFiveItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function claim() external view {
        uint256 profit = userInfo[msg.sender].profitDept;

        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfSand) {
            profit += itemInfo[0].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfSky) {
            profit += itemInfo[1].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfSea) {
            profit += itemInfo[2].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfCloud) {
            profit += itemInfo[3].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfSun) {
            profit += itemInfo[4].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfGull) {
            profit += itemInfo[5].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfPalm) {
            profit += itemInfo[6].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfCoconuts) {
            profit += itemInfo[7].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfGoldFish) {
            profit += itemInfo[8].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfCrab) {
            profit += itemInfo[9].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfShells) {
            profit += itemInfo[10].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfColoredStones) {
            profit += itemInfo[11].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfSandCastel) {
            profit += itemInfo[12].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfChaiseLounge) {
            profit += itemInfo[13].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfTowel) {
            profit += itemInfo[14].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfSuncreen) {
            profit += itemInfo[15].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfBasket) {
            profit += itemInfo[16].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfUmbrella) {
            profit += itemInfo[17].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfBoa) {
            profit += itemInfo[18].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSunglasses) {
            profit += itemInfo[19].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfBaseballCap) {
            profit += itemInfo[20].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSwimsuitTop) {
            profit += itemInfo[21].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSwimsuitBriefs) {
            profit += itemInfo[22].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfCrocs) {
            profit += itemInfo[23].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfFlamingoRing) {
            profit += itemInfo[24].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfDrink) {
            profit += itemInfo[25].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfGoldenColor) {
            profit += itemInfo[26].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfSmartWatch) {
            profit += itemInfo[27].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfSmartphone) {
            profit += itemInfo[28].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfYacht) {
            profit += itemInfo[29].dailyProfit;
        }
    }

    function _validatelevelOneItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == 0 || 
            _itemType == 2 || 
            _itemType == 1 ||
            _itemType == 3 ||
            _itemType == 4 ||
            _itemType == 5
        );
    }
    
    function _validatelevelTwoItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == 6 || 
            _itemType == 7 || 
            _itemType == 8 ||
            _itemType == 9 ||
            _itemType == 10 ||
            _itemType == 11
        );
    }

    function _validatelevelThreeItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == 12 || 
            _itemType == 13 || 
            _itemType == 14 ||
            _itemType == 15 ||
            _itemType == 16 ||
            _itemType == 17
        );
    }

    function _validatelevelFourItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == 18 || 
            _itemType == 19 || 
            _itemType == 20 ||
            _itemType == 21 ||
            _itemType == 22 ||
            _itemType == 23
        );
    }

    function _validatelevelFiveItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == 24 || 
            _itemType == 25 || 
            _itemType == 26 ||
            _itemType == 27 ||
            _itemType == 28 ||
            _itemType == 29
        );
    }
}