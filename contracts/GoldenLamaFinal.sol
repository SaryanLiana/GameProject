// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract GoldenLama {

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
    uint8 private constant TOWEL_PURCHASE_TYPE = 14;
    uint8 private constant SUNSCREEN_PURCHASE_TYPE = 15;
    uint8 private constant BASKET_PURCHASE_TYPE = 16;
    uint8 private constant UMBRELLA_PURCHASE_TYPE = 17;
    uint8 private constant BOA_PURCHASE_TYPE = 18;
    uint8 private constant SUNGLASSES_PURCHASE_TYPE = 19;
    uint8 private constant BASEBALL_CAP_PURCHASE_TYPE = 20;
    uint8 private constant SWIMSUIT_TOP_PURCHASE_TYPE = 21;
    uint8 private constant SWIMSUIT_BRIEFS_PURCHASE_TYPE = 22;
    uint8 private constant CROCS_PURCHASE_TYPE = 23;
    uint8 private constant FLAMINGO_RING_PURCHASE_TYPE = 24;
    uint8 private constant DRINK_PURCHASE_TYPE = 25;
    uint8 private constant GOLDEN_COLOR_PURCHASE_TYPE = 26;
    uint8 private constant SMART_WATCH_PURCHASE_TYPE = 27;
    uint8 private constant SMARTPHONE_PURCHASE_TYPE = 28;
    uint8 private constant YACHT_PURCHASE_TYPE = 29;

    uint32 private constant SAND_DAILY_PROFIT = 1181;
    uint32 private constant SKY_DAILY_PROFIT = 2396;
    uint32 private constant SEA_DAILY_PROFIT = 3600;
    uint32 private constant CLOUD_DAILY_PROFIT = 4870;
    uint32 private constant SUN_DAILY_PROFIT = 6180;
    uint32 private constant GULL_DAILY_PROFIT = 7489;
    uint32 private constant PALM_DAILY_PROFIT = 8792;
    uint32 private constant COCONUTS_DAILY_PROFIT = 10069;
    uint32 private constant GOLD_FISH_DAILY_PROFIT = 11618;
    uint32 private constant CRAB_DAILY_PROFIT = 13782;
    uint32 private constant SHELLS_DAILY_PROFIT = 14896;
    uint32 private constant COLORED_STONES_DAILY_PROFIT = 17075;
    uint32 private constant SAND_CASTEL_DAILY_PROFIT = 19288;
    uint32 private constant CHAISE_LOUNGE_DAILY_PROFIT = 21519;
    uint32 private constant TOWEL_DAILY_PROFIT = 26052;
    uint32 private constant SUNSCREEN_DAILY_PROFIT = 34707;
    uint32 private constant BASKET_DAILY_PROFIT = 43715;
    uint32 private constant UMBRELLA_DAILY_PROFIT = 54860;
    uint32 private constant BOA_DAILY_PROFIT = 65919;
    uint32 private constant SUNGLASSES_DAILY_PROFIT = 77639;
    uint32 private constant BASEBALL_CAP_DAILY_PROFIT = 88888;
    uint32 private constant SWIMSUIT_TOP_DAILY_PROFIT = 111482;
    uint32 private constant SWIMSUIT_BRIEFS_DAILY_PROFIT = 146100;
    uint32 private constant CROCS_DAILY_PROFIT = 179856;
    uint32 private constant FLAMINGO_RING_DAILY_PROFIT = 227790;
    uint32 private constant DRINK_DAILY_PROFIT = 273660;
    uint32 private constant GOLDEN_COLOR_DAILY_PROFIT = 343249;
    uint32 private constant SMART_WATCH_DAILY_PROFIT = 413602;
    uint32 private constant SMARTPHONE_DAILY_PROFIT = 533271;
    uint32 private constant YACHT_DAILY_PROFIT = 705384;

    uint64 private constant PRICE_OF_COCKTAIL = 30000000000000;
    uint64 private constant PRICE_OF_COIN = 300000000000;

    address public owner;
    uint256 public usersCount;
    uint256 public startTimestamp;
    uint256[30] public prices;
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

    constructor(uint256[30] memory _prices) {
        owner = msg.sender;
        startTimestamp = block.timestamp;
        usersCount = 1;
        _setPrices(_prices);
    }

    receive() external payable {}

    fallback() external payable {}

    function setAdminStatus(address _admin, bool _status) external onlyAdmin{
        isAdmin[_admin] = _status;
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
        require(_count > prices[0], "GoldenLama:: Cocktails count to buy should be greater than 600!");
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
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 1 item!");
        _validatelevelOneItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];
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
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 2 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the first line!");
        _validatelevelTwoItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];
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
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 3 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");      
        _validatelevelThreeItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];
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
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 4 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true && levelThreeItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");      
        _validatelevelFourItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];
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
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 5 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true && levelThreeItemInfo[msg.sender].allItemsBought == true && levelFourItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");
        _validatelevelFiveItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];
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
    
    function claim() external {
        uint256 profit = userInfo[msg.sender].profitDept;
        uint256 sandTime = levelOneItemInfo[msg.sender].timestampOfSand;
        uint256 skyTime = levelOneItemInfo[msg.sender].timestampOfSky;
        uint256 seaTime = levelOneItemInfo[msg.sender].timestampOfSea;
        uint256 cloudTime = levelOneItemInfo[msg.sender].timestampOfCloud;
        uint256 sunTime = levelOneItemInfo[msg.sender].timestampOfSun;
        uint256 gullTime = levelOneItemInfo[msg.sender].timestampOfGull;
        uint256 palmTime = levelTwoItemInfo[msg.sender].timestampOfPalm;
        uint256 coconutTime = levelTwoItemInfo[msg.sender].timestampOfCoconuts;
        uint256 fishTime = levelTwoItemInfo[msg.sender].timestampOfGoldFish;
        uint256 crabTime = levelTwoItemInfo[msg.sender].timestampOfCrab; 
        uint256 shellTime = levelTwoItemInfo[msg.sender].timestampOfShells;
        uint256 stoneTime = levelTwoItemInfo[msg.sender].timestampOfColoredStones;
        uint256 castelTime = levelThreeItemInfo[msg.sender].timestampOfSandCastel;
        uint256 CLTime = levelThreeItemInfo[msg.sender].timestampOfChaiseLounge;

        if(block.timestamp + 1 days > sandTime) {
            sandTime = block.timestamp;
            profit += SAND_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > skyTime) {
            skyTime = block.timestamp;
            profit += SKY_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > seaTime) {
            seaTime = block.timestamp;
            profit += SEA_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > cloudTime) {
            cloudTime = block.timestamp;
            profit += CLOUD_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > sunTime) {
            sunTime = block.timestamp;
            profit += SUN_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > gullTime) {
            gullTime = block.timestamp;
            profit += GULL_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > palmTime) {
            palmTime = block.timestamp;
            profit += PALM_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > coconutTime) {
            coconutTime = block.timestamp;
            profit += COCONUTS_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > fishTime) {
            fishTime = block.timestamp;
            profit += GOLD_FISH_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > crabTime) {
            crabTime = block.timestamp;
            profit += CRAB_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > shellTime) {
            shellTime = block.timestamp;
            profit += SHELLS_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > stoneTime) {
            stoneTime = block.timestamp;
            profit += COLORED_STONES_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > castelTime) {
            castelTime = block.timestamp;
            profit += SAND_CASTEL_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > CLTime) {
            CLTime = block.timestamp;
            profit += CHAISE_LOUNGE_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfTowel) {
            levelThreeItemInfo[msg.sender].timestampOfTowel = block.timestamp;
            profit += TOWEL_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfSuncreen) {
            levelThreeItemInfo[msg.sender].timestampOfSuncreen = block.timestamp;
            profit += SUNSCREEN_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfBasket) {
            levelThreeItemInfo[msg.sender].timestampOfBasket = block.timestamp;
            profit += BASKET_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfUmbrella) {
            levelThreeItemInfo[msg.sender].timestampOfUmbrella = block.timestamp;
            profit += UMBRELLA_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfBoa) {
            levelFourItemInfo[msg.sender].timestampOfBoa = block.timestamp;
            profit += BOA_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSunglasses) {
            levelFourItemInfo[msg.sender].timestampOfSunglasses = block.timestamp;
            profit += SUNGLASSES_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfBaseballCap) {
            levelFourItemInfo[msg.sender].timestampOfBaseballCap = block.timestamp;
            profit += BASEBALL_CAP_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSwimsuitTop) {
            levelFourItemInfo[msg.sender].timestampOfSwimsuitTop = block.timestamp;
            profit += SWIMSUIT_TOP_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSwimsuitBriefs) {
            levelFourItemInfo[msg.sender].timestampOfSwimsuitBriefs = block.timestamp;
            profit += SWIMSUIT_BRIEFS_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfCrocs) {
            levelFourItemInfo[msg.sender].timestampOfCrocs = block.timestamp;
            profit += CROCS_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfFlamingoRing) {
            levelFiveItemInfo[msg.sender].timestampOfFlamingoRing = block.timestamp;
            profit += FLAMINGO_RING_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfDrink) {
            levelFiveItemInfo[msg.sender].timestampOfDrink = block.timestamp;
            profit += DRINK_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfGoldenColor) {
            levelFiveItemInfo[msg.sender].timestampOfGoldenColor = block.timestamp;
            profit += GOLDEN_COLOR_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfSmartWatch) {
            levelFiveItemInfo[msg.sender].timestampOfSmartWatch = block.timestamp;
            profit += SMART_WATCH_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfSmartphone) {
            levelFiveItemInfo[msg.sender].timestampOfSmartphone = block.timestamp;
            profit += SMARTPHONE_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfYacht) {
            levelFiveItemInfo[msg.sender].timestampOfYacht = block.timestamp;
            profit += YACHT_DAILY_PROFIT;
        }
    }

    function _setPrices(uint256[30] memory _prices) private {
        prices = _prices;
    }


    function _validatelevelOneItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == SAND_PURCHASE_TYPE || 
            _itemType == SEA_PURCHASE_TYPE || 
            _itemType == SKY_PURCHASE_TYPE ||
            _itemType == CLOUD_PURCHASE_TYPE ||
            _itemType == SUN_PURCHASE_TYPE ||
            _itemType == GULL_PURCHASE_TYPE
        );
    }
    
    function _validatelevelTwoItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == PALM_PURCHASE_TYPE || 
            _itemType == COCONUTS_PURCHASE_TYPE || 
            _itemType == GOLD_FISH_PURCHASE_TYPE ||
            _itemType == CRAB_PURCHASE_TYPE ||
            _itemType == SHELLS_PURCHASE_TYPE ||
            _itemType == COLORED_STONES_PURCHASE_TYPE
        );
    }

    function _validatelevelThreeItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == SAND_CASTEL_PURCHASE_TYPE || 
            _itemType == CHAISE_LOUNGE_PURCHASE_TYPE || 
            _itemType == TOWEL_PURCHASE_TYPE ||
            _itemType == SUNSCREEN_PURCHASE_TYPE ||
            _itemType == BASKET_PURCHASE_TYPE ||
            _itemType == UMBRELLA_PURCHASE_TYPE
        );
    }

    function _validatelevelFourItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == BOA_PURCHASE_TYPE || 
            _itemType == SUNGLASSES_PURCHASE_TYPE || 
            _itemType == BASEBALL_CAP_PURCHASE_TYPE ||
            _itemType == SWIMSUIT_TOP_PURCHASE_TYPE ||
            _itemType == SWIMSUIT_BRIEFS_PURCHASE_TYPE ||
            _itemType == CROCS_PURCHASE_TYPE
        );
    }

    function _validatelevelFiveItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == FLAMINGO_RING_PURCHASE_TYPE || 
            _itemType == DRINK_PURCHASE_TYPE || 
            _itemType == GOLDEN_COLOR_PURCHASE_TYPE ||
            _itemType == SMART_WATCH_PURCHASE_TYPE ||
            _itemType == SMARTPHONE_PURCHASE_TYPE ||
            _itemType == YACHT_PURCHASE_TYPE
        );
    }
}