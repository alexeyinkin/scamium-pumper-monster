# PumperMonster - Scamium

This script estimates the life expectancy of the [PumperMonster](https://pumper.monster/36GMKP) pyramid.

My analysis of this pyramid and the interpretation of results is
[here](https://blog.scamium.com/pumpermonster-when-will-the-pyramid-collapse-aa2cab341e1a).

Requirements:

1. Install [Dart](https://dart.dev).
2. Get a BSC archive node.
   I use [MegaNode](https://nodereal.io/invite/36506693-1150-4c88-80ca-5b4564b10174),
   their free tier is sufficient.
3. Put your node URL to the `nodeUrl` constant in the code.
4. [Download](https://bscscan.com/exportData?type=address&a=0x443567e30E72fe278Bcf0FE2399E1ac0C271ccdB)
   the transaction CSV data from BscScan.
   It allows you to get at most 5000 transactions in a single file.
   If there are more transactions, download multiple files.
   These files may overlap, each transaction will only be processed once.
5. Put the CSV files into the `transactions` directory.
   The files should be named alphabetically with the earlier transactions in the earlier files.
   Files that come with this repository cover the given dates, so you only need to download
   the data for the newer dates and make sure your files are named alphabetically after
   the bundled ones.

Run the script like this:

```bash
dart main.dart
```

If you do not have a BSC node, you can run the script without extra blockchain data
using the exported transactions alone. For that, comment out the line that reads

```dart
await record.fillBlockchainData();
```
