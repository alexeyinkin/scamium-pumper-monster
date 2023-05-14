import 'dart:collection';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';

import 'package:http/io_client.dart';
import 'package:web3dart/web3dart.dart';

// PUT YOUR KEY HERE:
const nodeUrl = '';

final tokenAddress =
    EthereumAddress.fromHex('0x3926b1a235cc293153e87476046cc0036b830d21');
final projectAddress =
    EthereumAddress.fromHex('0x443567e30E72fe278Bcf0FE2399E1ac0C271ccdB');

final tokenContract = DeployedContract(
  ContractAbi.fromJson(
    '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"spender","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"}],"name":"Paused","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"previousAdminRole","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"newAdminRole","type":"bytes32"}],"name":"RoleAdminChanged","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleGranted","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleRevoked","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"}],"name":"Unpaused","type":"event"},{"inputs":[],"name":"DEFAULT_ADMIN_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"MINTER_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"PAUSER_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"spender","type":"address"}],"name":"allowance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"approve","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"burn","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"burnFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"subtractedValue","type":"uint256"}],"name":"decreaseAllowance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"receiver","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"exchangeTokens","outputs":[{"internalType":"bool","name":"approved","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"receiver","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"game","type":"uint256"}],"name":"gameTokens","outputs":[{"internalType":"bool","name":"approved","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"}],"name":"getRoleAdmin","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"grantRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"hasRole","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"addedValue","type":"uint256"}],"name":"increaseAllowance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"mint","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pause","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"paused","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"renounceRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"revokeRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transferFrom","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"unpause","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
    '',
  ),
  tokenAddress,
);

final projectContract = DeployedContract(
  ContractAbi.fromJson(
    '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"allowedAddress","type":"address"},{"indexed":false,"internalType":"bool","name":"allowed","type":"bool"}],"name":"AccessAllowed","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"uint256","name":"exchangeId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"price","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amountReceived","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amountSent","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"exchangedAt","type":"uint256"}],"name":"ExchangeTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"uint256","name":"gameId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"multiplier","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"chance","type":"uint256"},{"indexed":false,"internalType":"bool","name":"winning","type":"bool"},{"indexed":false,"internalType":"uint8","name":"gameCount","type":"uint8"},{"indexed":false,"internalType":"uint256","name":"amountBet","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amountWon","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"createdAt","type":"uint256"}],"name":"GameResults","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"uint256","name":"pumpId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"dailyPercent","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"whiteListBonus","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"userBonus","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"extraBonus","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"createdAt","type":"uint256"}],"name":"PumpCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"uint256","name":"pumpId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"dailyPercent","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"whiteListBonus","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"userBonus","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"extraBonus","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amountDeposited","type":"uint256"}],"name":"PumpDeposited","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"uint256","name":"pumpId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"dailyPercent","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"daysReward","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amountReward","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"withdrawnAt","type":"uint256"}],"name":"PumpRewardTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"address","name":"referral","type":"address"},{"indexed":true,"internalType":"uint256","name":"pumpId","type":"uint256"},{"indexed":false,"internalType":"uint8","name":"line","type":"uint8"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amountReward","type":"uint256"},{"indexed":false,"internalType":"bool","name":"deposited","type":"bool"}],"name":"ReferralRewardTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"uint256","name":"userId","type":"uint256"},{"indexed":true,"internalType":"address","name":"referral","type":"address"},{"indexed":false,"internalType":"uint256","name":"createdAt","type":"uint256"}],"name":"UserAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"user","type":"address"},{"indexed":true,"internalType":"address","name":"referral","type":"address"},{"indexed":false,"internalType":"bool","name":"banned","type":"bool"},{"indexed":false,"internalType":"uint256","name":"bonus","type":"uint256"}],"name":"UserUpdated","type":"event"},{"stateMutability":"payable","type":"fallback"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"accessAlloweds","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"activeDepositReferralReward","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"activeExchange","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"activeExtraBonus","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"activeGame","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"activeUserBonus","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"activeWiteList","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"activeWithdrawReferralReward","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"additionalTokenPrice","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"value","type":"address"}],"name":"authAddress","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"token","type":"address"}],"name":"balanceTokens","outputs":[{"internalType":"uint256","name":"balance","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"pumpId","type":"uint256"}],"name":"deposit","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"deposit","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"referral","type":"address"}],"name":"deposit","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"depositsCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"address","name":"token","type":"address"}],"name":"exchangeTokens","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"exchanges","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"price","type":"uint256"},{"internalType":"uint256","name":"amountReceived","type":"uint256"},{"internalType":"uint256","name":"amountSent","type":"uint256"},{"internalType":"uint256","name":"exchangedAt","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"extraBonusAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"feeAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"gamePeriod","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"address","name":"token","type":"address"},{"internalType":"uint256","name":"game","type":"uint256"}],"name":"gameTokens","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"games","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"multiplier","type":"uint256"},{"internalType":"uint256","name":"chance","type":"uint256"},{"internalType":"bool","name":"winning","type":"bool"},{"internalType":"uint8","name":"gameCount","type":"uint8"},{"internalType":"uint256","name":"amountBet","type":"uint256"},{"internalType":"uint256","name":"amountTotalBet","type":"uint256"},{"internalType":"uint256","name":"amountWon","type":"uint256"},{"internalType":"uint256","name":"amountTotalWon","type":"uint256"},{"internalType":"uint256","name":"amountLoss","type":"uint256"},{"internalType":"uint256","name":"createdAt","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"gamesCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"gameId","type":"uint256"}],"name":"getGameMultiplier","outputs":[{"internalType":"uint256","name":"multiplier","type":"uint256"},{"internalType":"uint256","name":"chance","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"pumpId","type":"uint256"}],"name":"getPump","outputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"dailyPercent","type":"uint256"},{"internalType":"uint256","name":"amountDeposited","type":"uint256"},{"internalType":"uint256","name":"amountWithdrawn","type":"uint256"},{"internalType":"uint256","name":"withdrawnDaysCount","type":"uint256"},{"internalType":"uint256","name":"createdAt","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"pumpId","type":"uint256"},{"internalType":"address","name":"user","type":"address"}],"name":"getPumpPercentage","outputs":[{"internalType":"uint256","name":"percentage","type":"uint256"},{"internalType":"uint256","name":"whiteListBonus","type":"uint256"},{"internalType":"uint256","name":"userBonus","type":"uint256"},{"internalType":"uint256","name":"extraBonus","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"pumpId","type":"uint256"}],"name":"getRewardsAmount","outputs":[{"internalType":"uint256","name":"rewardDays","type":"uint256"},{"internalType":"uint256","name":"rewardAmount","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"}],"name":"getUser","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"referral","type":"address"},{"internalType":"bool","name":"banned","type":"bool"},{"internalType":"uint256","name":"createdAt","type":"uint256"},{"internalType":"uint256","name":"bonus","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"}],"name":"isUserBanned","outputs":[{"internalType":"bool","name":"exists","type":"bool"},{"internalType":"bool","name":"banned","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"}],"name":"isUserExists","outputs":[{"internalType":"bool","name":"exists","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"lastExchangedAt","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"maxExchangePercent","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"minExchangePercent","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"minGameAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"minPumpAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"nextExchangeId","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"nextGameId","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"nextPumpId","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"nextUserId","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"ownerAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"paused","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pumpIdsWiteList","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pumpPeriod","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pumpWiteListBonus","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"pumps","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"amountDeposited","type":"uint256"},{"internalType":"uint256","name":"amountWithdrawn","type":"uint256"},{"internalType":"uint256","name":"dailyPercent","type":"uint256"},{"internalType":"uint256","name":"whiteListBonus","type":"uint256"},{"internalType":"uint256","name":"userBonus","type":"uint256"},{"internalType":"uint256","name":"extraBonus","type":"uint256"},{"internalType":"uint256","name":"withdrawnDaysCount","type":"uint256"},{"internalType":"uint256","name":"createdAt","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pumpsCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"}],"name":"registration","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"registration","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"address","name":"referral","type":"address"}],"name":"registration","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"startDate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"tokenAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"tokenPrice","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint8","name":"id","type":"uint8"},{"internalType":"address","name":"value","type":"address"}],"name":"updateAddress","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint8","name":"id","type":"uint8"}],"name":"updateBool","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint8","name":"id","type":"uint8"},{"internalType":"uint256","name":"value","type":"uint256"}],"name":"updateUint","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"address","name":"referral","type":"address"},{"internalType":"bool","name":"banned","type":"bool"},{"internalType":"uint256","name":"bonus","type":"uint256"}],"name":"updateUser","outputs":[{"internalType":"bool","name":"updated","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"userIdsAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"users","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"referral","type":"address"},{"internalType":"bool","name":"banned","type":"bool"},{"internalType":"uint256","name":"createdAt","type":"uint256"},{"internalType":"uint256","name":"bonus","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"usersActiveGames","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"usersActivePumps","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"usersCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"pumpId","type":"uint256"}],"name":"withdraw","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"withdraw","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"token","type":"address"},{"internalType":"uint256","name":"value","type":"uint256"}],"name":"withdrawTokens","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"}]',
    '',
  ),
  projectAddress,
);

const txDirName = 'transactions';

const columns = [
  'Date',
  'Block',
  'BNB Deposits',
  'BNB Value',
  'PUMPUP Supply',
  'PUMPUP/BNB',
  'BNB Daily Rewards',
  'Daily Rewards %',
];

// Columns in BscScan transaction export:
const hashColumn = 0;
const blockColumn = 1;
const timestampColumn = 2;
const fromColumn = 4;
const valueInColumn = 7;
const methodColumn = 15;

final client = Web3Client(nodeUrl, IOClient(HttpClient()));

Future<void> main() async {
  final result = Result();
  final users = Users();

  final txDir = Directory(txDirName);
  final processedHashes = <String>{};

  DateRecord? lastRecord;

  final files = txDir.listSync().sorted((a, b) => a.path.compareTo(b.path));

  for (final file in files) {
    if (file is! File) {
      continue;
    }

    print('Reading ${file.path}');

    final txString = file.readAsStringSync();
    final txList = const CsvToListConverter().convert(txString);
    txList.removeAt(0); // Header.

    for (final row in txList) {
      final hash = row[hashColumn];
      if (processedHashes.contains(hash)) {
        continue;
      }
      processedHashes.add(hash);

      final block = int.parse(row[blockColumn]);
      final secondsSinceEpoch = int.parse(row[timestampColumn]);
      final from = row[fromColumn];
      final valueIn = double.parse(row[valueInColumn]);
      final method = row[methodColumn];

      final record = result.getDateRecord(secondsSinceEpoch);

      if (record != lastRecord) {
        lastRecord?.rewardBuckets.addUsers(users);
      }

      record.setBlockIfNewIsAfter(block);

      final user = users.getUser(from);

      switch (method) {
        case 'Deposit':
          record.bnbDeposits += valueIn;
          user.bnbDeposits += valueIn;
          break;
      }

      lastRecord = record;
    }
  }

  lastRecord?.rewardBuckets.addUsers(users);

  for (final record in result._dates.values) {
    await record.fillBlockchainData();
  }

  // await result._dates.values
  //     .elementAt(result._dates.length - 4)
  //     .fillBlockchainData();
  // await result._dates.values
  //     .elementAt(result._dates.length - 3)
  //     .fillBlockchainData();
  // await result._dates.values
  //     .elementAt(result._dates.length - 2)
  //     .fillBlockchainData();
  // await result._dates.values.last.fillBlockchainData();

  print(result);
  print('\n\n');
  // print(users);
  // print('\n\n');
  print(result._dates.values.lastOrNull?.rewardBuckets);
}

class Result {
  final _dates = SplayTreeMap<DateTime, DateRecord>();

  DateRecord getDateRecord(int secondsSinceEpoch) {
    final dt =
        DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000).toUtc();
    final utcMidnight = DateTime.utc(dt.year, dt.month, dt.day);

    final result = _dates[utcMidnight] ??
        DateRecord(
          utcMidnight: utcMidnight,
          previous: _dates.values.lastOrNull,
        );

    _dates[utcMidnight] = result;
    return result;
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(columns.join('\t'));

    for (final record in _dates.values) {
      buffer.writeln(record.toString());
    }

    return buffer.toString();
  }
}

class DateRecord {
  DateRecord({
    required this.utcMidnight,
    required this.previous,
  }) {
    previous?.next = this;
  }

  DateRecord? next;
  final DateRecord? previous;

  final DateTime utcMidnight;

  /// Block of the earliest transaction on this contract on this date.
  int block = 0;

  double bnbDeposits = 0;

  double bnbValue = 0;

  double pumpupTotalSupply = 0;

  double pumpupToBnb = 0;

  final rewardBuckets = RewardBuckets();

  void setBlockIfNewIsAfter(int newValue) {
    if (block != 0 && block >= newValue) {
      return;
    }

    block = newValue;
  }

  @override
  String toString() {
    final data = [
      utcMidnight.toIso8601String().substring(0, 'YYYY-MM-DD'.length),
      block,
      bnbDeposits.toStringAsFixed(2),
      bnbValue.toStringAsFixed(2),
      pumpupTotalSupply.toStringAsFixed(2),
      pumpupToBnb.toStringAsFixed(6),
      rewardBuckets.getDailyReward().toStringAsFixed(2),
      (rewardBuckets.getAverageRewardRate() * 100).toStringAsFixed(3),
    ];

    return data.join('\t');
  }

  Future<void> fillBlockchainData() async {
    final lastBlockOfDay = _getLastBlockOfDay();

    final pumpupTotalSupplyWei = await getConstant<BigInt>(
      tokenContract,
      'totalSupply',
      lastBlockOfDay,
    );
    pumpupTotalSupply = weiToDouble(
      pumpupTotalSupplyWei,
    );

    final balance = await client.getBalance(
      projectAddress,
      atBlock: lastBlockOfDay,
    );
    bnbValue = weiToDouble(balance.getInWei);

    final pumpupToBnbWei = await getConstant<BigInt>(
      projectContract,
      'tokenPrice',
      lastBlockOfDay,
    );
    pumpupToBnb = weiToDouble(
      pumpupToBnbWei,
    );
  }

  BlockNum _getLastBlockOfDay() {
    if (next == null) {
      return BlockNum.current();
    }

    return BlockNum.exact(block);
  }
}

class Users {
  final _users = SplayTreeMap<String, User>();

  User getUser(String address) {
    final result = _users[address] ?? User(address: address);
    _users[address] = result;
    return result;
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(columns.join('\t'));

    final list = _users.values.toList(growable: false);
    list.sort(User.sortByBnbDepositsDesc);

    for (final user in list) {
      buffer.writeln(user.toString());
    }

    return buffer.toString();
  }
}

class User {
  User({
    required this.address,
  });

  final String address;
  double bnbDeposits = 0;

  static int sortByBnbDepositsDesc(User a, User b) {
    return (b.bnbDeposits - a.bnbDeposits).sign.ceil();
  }

  @override
  String toString() {
    final data = [
      address,
      bnbDeposits.toStringAsFixed(2),
    ];

    return data.join('\t');
  }
}

class RewardBuckets {
  final bucket200;
  final bucket225;
  final bucket250;
  final bucket275;
  final bucket300;

  RewardBuckets._({
    required this.bucket200,
    required this.bucket225,
    required this.bucket250,
    required this.bucket275,
    required this.bucket300,
  });

  RewardBuckets()
      : this._(
          bucket200: RewardBucket(percent: 2.00),
          bucket225: RewardBucket(percent: 2.25),
          bucket250: RewardBucket(percent: 2.50),
          bucket275: RewardBucket(percent: 2.75),
          bucket300: RewardBucket(percent: 3.00),
        );

  late final buckets = [
    bucket200,
    bucket225,
    bucket250,
    bucket275,
    bucket300,
  ];

  void addUsers(Users users) {
    users._users.values.forEach(addUser);
  }

  void addUser(User user) {
    getBucket(user).addUser(user);
  }

  RewardBucket getBucket(User user) {
    final bnbDeposits = user.bnbDeposits;

    if (bnbDeposits >= 10) {
      return bucket300;
    }

    if (bnbDeposits >= 5) {
      return bucket275;
    }

    if (bnbDeposits >= 2.5) {
      return bucket250;
    }

    if (bnbDeposits >= 1) {
      return bucket225;
    }

    return bucket200;
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    final totalBnbDeposits = getTotalDeposits();

    final headers = [
      'Reward',
      'BNB Deposits',
      'Fraction',
    ];
    buffer.writeln(headers.join('\t'));

    for (final bucket in buckets) {
      final row = [
        bucket.percent.toStringAsFixed(2),
        bucket.bnbDeposits.toStringAsFixed(2),
        '=' * (100 * bucket.bnbDeposits / totalBnbDeposits).ceil(),
      ];
      buffer.writeln(row.join('\t'));
    }

    final dailyReward = getDailyReward();
    final avg = getAverageRewardRate();
    buffer
        .writeln('Weighted average reward: ${(avg * 100).toStringAsFixed(3)}%');
    buffer.writeln(
        'Daily reward:            ${dailyReward.toStringAsFixed(2)} BNB');
    return buffer.toString();
  }

  double getTotalDeposits() {
    return buckets
        .map((b) => b.bnbDeposits)
        .reduce((value, element) => value + element);
  }

  double getDailyReward() {
    double result = 0;

    for (final bucket in buckets) {
      result += bucket.getDailyReward();
    }

    return result;
  }

  double getAverageRewardRate() {
    return getDailyReward() / getTotalDeposits();
  }

  RewardBuckets clone() {
    return RewardBuckets._(
      bucket200: bucket200.clone(),
      bucket225: bucket225.clone(),
      bucket250: bucket250.clone(),
      bucket275: bucket275.clone(),
      bucket300: bucket300.clone(),
    );
  }
}

class RewardBucket {
  RewardBucket({
    required this.percent,
  });

  final double percent;
  double bnbDeposits = 0;

  void addUser(User user) {
    bnbDeposits += user.bnbDeposits;
  }

  double getDailyReward() => percent * bnbDeposits / 100;

  RewardBucket clone() {
    final result = RewardBucket(percent: percent);
    result.bnbDeposits = bnbDeposits;
    return result;
  }
}

Future<T> getConstant<T>(
    DeployedContract contract, String name, BlockNum block) async {
  final fn = () => client.call(
        contract: contract,
        function: contract.function(name),
        params: [],
        atBlock: block,
      );
  final result = await fn();
  // final result = await myRetry(fn);
  return result[0];
}

double weiToDouble(BigInt n) {
  return n.toDouble() / 1e+18;
}
