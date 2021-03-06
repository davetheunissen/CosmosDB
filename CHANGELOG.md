# Change Log

## 2.1.7.675

- Added support for running CI in Azure DevOps Pipelines - fixes [Issue #174](https://github.com/PlagueHO/CosmosDB/issues/174)

## 2.1.7.635

- Added `New-CosmosDbAccount` function for creating a new Cosmos DB
  account in Azure - fixes [Issue #111](https://github.com/PlagueHO/CosmosDB/issues/111)
- Added `Get-CosmosDbAccount` function for retrieving the properties
  of an existing account in Azure - fixes [Issue #159](https://github.com/PlagueHO/CosmosDB/issues/159)
- Added `Set-CosmosDbAccount` function for updating an existing Cosmos DB
  account in Azure - fixes [Issue #160](https://github.com/PlagueHO/CosmosDB/issues/160)
- Added `Remove-CosmosDbAccount` function for removing an existing Cosmos DB
  account in Azure - fixes [Issue #161](https://github.com/PlagueHO/CosmosDB/issues/161)
- Added OSx and Linux PowerShell Core continuous integration using
  TravisCI.
- Improved CI/CodeCoverage badges in README.MD.
- Improved build process to handle build environments that do not
  have Administrator/Root access.
- Skip test for `Convert-CosmosDbRequestBody` when run in Linux/OSx using
  PowerShell Core due to behavior difference - see [PowerShell Core #Issue](https://github.com/PowerShell/PowerShell/issues/7693)
- Skip integration tests for `New-CosmosDbAccount` and `Set-CosmosDbAccount`
  when run in AppVeyor due to exception occuring in `New-AzureRmResource` and
  `Set-AzureRmResource` cmdlets because of Newtonsoft.Json version conflict.

## 2.1.6.561

- Updated partition key handling when creating collections to allow for
  leading '/' characters in the partition key - fixes [Issue #153](https://github.com/PlagueHO/CosmosDB/issues/153)
- Add support for setting URI and Key when using with a Cosmos DB
  Emulator - fixes [Issue #155](https://github.com/PlagueHO/CosmosDB/issues/155)

## 2.1.5.548

- Changed references to `CosmosDB` to `Cosmos DB` in documentation - fixes [Issue #147](https://github.com/PlagueHO/CosmosDB/issues/147)

## 2.1.4.536

- Added `RemoveDefaultTimeToLive` switch parameter to `Set-CosmosDbCollection`
  to allow removal of a default time to live setting on a collection - fixes [Issue #144](https://github.com/PlagueHO/CosmosDB/issues/144)

## 2.1.3.528

- Changed `New-CosmosDbStoredProcedure` & `Set-CosmosDbStoredProcedure` to use serialization
  instead of tricky request body conversion - fixes
  [Issue #137](https://github.com/PlagueHO/CosmosDB/issues/137)
- Added parameter `DefaultTimeToLive` to `New-CosmosDbCollection` and
  `Set-CosmosDbCollection` - fixes [Issue #139](https://github.com/PlagueHO/CosmosDB/issues/139)
- Changed the `IndexingPolicy` parameter on`Set-CosmosDbCollection`
  to be optional - fixes [Issue #140](https://github.com/PlagueHO/CosmosDB/issues/140)

## 2.1.2.514

- Changed `New-CosmosDBContext` so that Read Only keys will use the
  `readonlykeys` action endpoint instead of the `listKeys` action - fixes
  [Issue #133](https://github.com/PlagueHO/CosmosDB/issues/133)
- Fixed freeze occuring in functions when `-ErrorAction SilentlyContinue`
  parameter was used and error is returned - fixes [Issue #132](https://github.com/PlagueHO/CosmosDB/issues/132)

## 2.1.1.498

- Changed trigger operation type `Insert` to `Create` in `New-CosmosDBTrigger`
  and `Set-CosmosDBTrigger` functions - fixes [Issue #129](https://github.com/PlagueHO/CosmosDB/issues/129)

## 2.1.0.487

- Removed `UseWebRequest` parameter from `Invoke-CosmosDbReuest` function
  to refactor out the use of `Invoke-RestMethod`. This is because most
  Cosmos DB REST requests return additional header information that is
  lost if using `Invoke-RestMethod`. `Invoke-WebRequest` is used instead
  so that additional headers can always be retured - See [Issue #125](https://github.com/PlagueHO/CosmosDB/issues/125)
- Added integration tests for attachments.
- Added integration tests for stored procedures.
- Added integration tests for triggers.
- Added integration tests for user defined functions.
- Added `New-CosmosDbBackOffPolicy` function for controlling the behaviour
  of a function when a "Too Many Request" (error code 429) is recieved -
  See [Issue #87](https://github.com/PlagueHO/CosmosDB/issues/87)
- Added support for handling a back-off policy to the `Invoke-CosmosDbRequest`
  function.

## 2.0.16.465

- Added None as an IndexingMode - See [Issue #120](https://github.com/PlagueHO/CosmosDB/issues/120)

## 2.0.15.454

- Fix creation of spatial index by `New-CosmosDbCollectionIncludedPathIndex`
  so that precision is not used when passing to `New-CosmosDbCollection`.
- Added support for `-PartitionKey` in `Invoke-CosmosDbStoredProcedure` - See [Issue #116](https://github.com/PlagueHO/CosmosDB/issues/116)
- Changed -StoredProcedureParameter from string[] to object[] in `Invoke-CosmosDbStoredProcedure` - See [Issue #116](https://github.com/PlagueHO/CosmosDB/issues/116)
- Updated `Invoke-CosmosDbStoredProcedure` to set `x-ms-documentdb-script-enable-logging: true` header and write stored procedure logs to the Verbose Stream when `-Debug` is set - See [Issue #116](https://github.com/PlagueHO/CosmosDB/issues/116)

## 2.0.14.439

- Fixed Code Coverage upload to CodeCov.io.
- Fix `New-CosmosDbCollectionIncludedPathIndex` Kind parameter spelling
  of spacial - See [Issue #112](https://github.com/PlagueHO/CosmosDB/issues/112).
- Added parameter validation to `New-CosmosDbCollectionIncludedPathIndex`.

## 2.0.13.427

- Added `Set-CosmosDbCollection` function for updating a collection - See
  [Issue #104](https://github.com/PlagueHO/CosmosDB/issues/104).
- Updated `Invoke-CosmosDbRequest` function to output additional exception
  information to the Verbose stream - See [Issue #103](https://github.com/PlagueHO/CosmosDB/issues/103).

## 2.0.12.418

- Changed Id parameter in `Get-CosmosDbCollectionSize` to be mandatory.
- Added documentation for creating a resource token context - See
  [Issue #33](https://github.com/PlagueHO/CosmosDB/issues/33).
- Added `New-CosmosDbContextToken` to create a resource token context
  object that can be passed to `New-CosmosDbContext` to support working
  with resource level access controls - See
  [Issue #33](https://github.com/PlagueHO/CosmosDB/issues/33).
- Added support to `New-CosmosDbContext` for creating a context object
  with resource tokens from permissions - See
  [Issue #33](https://github.com/PlagueHO/CosmosDB/issues/33).

## 2.0.11.407

- Added PowerShell Core version support badge.
- Prevent integration tests from running if Azure connection
  environment variables are not set.
- Added Code of Conduct to project.
- Fixed error returned by `Get-CosmosDbDocument` when getting documents
  from a partitioned collection without specifying an Id or Query - See
  [Issue #97](https://github.com/PlagueHO/CosmosDB/issues/97).
  Thanks [jasonchester](https://github.com/jasonchester)

## 2.0.10.388

- Added basic integration test support.
- Fixed 401 error returned by `Set-CosmosDbOffer` when
  updating offer - See [Issue #85](https://github.com/PlagueHO/CosmosDB/issues/85).
  Thanks [dl8on](https://github.com/dl8on)

## 2.0.9.360

- Added `Get-CosmosDbCollectionSize` function to return
  data about size and object counts of collections -
  See [Issue #79](https://github.com/PlagueHO/CosmosDB/issues/79).
  Thanks [WatersJohn](https://github.com/WatersJohn).

## 2.0.8.350

- Fixed `New-CosmosDbAuthorizationToken` function to support
  generating authorization tokens for case sensitive resource
  names - See [Issue #76](https://github.com/PlagueHO/CosmosDB/issues/76).
  Thanks [MWL88](https://github.com/MWL88).

## 2.0.7.288

- Updated CI process to use PSDepend for dependencies.
- Updated CI process to use PSake for tasks.
- Changes AppVeyor.yml to call PSake tasks.

## 2.0.6.247

- Added `PSEdition_Desktop` tag to manifest.
- Added cmdlet help examples for utils.
- Converted help to MAML file CosmosDB-help.xml.
- Updated AppVeyor build to generate MAML help.
- Added more README.MD badges.

## 2.0.5.216

- Added `*-CosmosDbOffer` cmdlets.

## 2.0.4.202

- Fixed bug in `Get-CosmosDbDocument` when looking up a document in
  a partitioned collection by adding a `PartitionKey` parameter.
- Added `Upsert` parameter to `New-CosmosDbDocument` to enable updating
  a document if it exists.
- Fixed bug in `New-CosmosDbDocument` when adding document to
  a partitioned collection but no partition key is specified - See
  [Issue #48](https://github.com/PlagueHO/CosmosDB/issues/48).
- Fixed bug in `Set-CosmosDbDocument` when updating a document in
  a partitioned collection.
- Fixed bug in `Remove-CosmosDbDocument` when deleting a document in
  a partitioned collection.
- Added check to `New-CosmosDbCollection` to ensure `PartitionKey`
  parameter is passed if `OfferThroughput` is greater than 10000.

## 2.0.3.190

- Added support for configuring custom indexing policies when
  creating a new collection.

## 2.0.2.184

- Converted all `connection` function names and parameter names
  over to `context`. Aliases were implemented for old `connection`
  function and parameter names to reduce possibility of breakage.

## 2.0.1.173

- Added support for CosmosDB Emulator.

## 2.0.0.163

- Fixed `New-CosmosDbConnection` error message when
  creating connection but not connected to Azure.
- Added support for specifying token expiry length to
  `Get-cosmosDbPermission`.

## 2.0.0.146

- BREAKING CHANGE: Converted all cmdlets to return custom types
  and added support for custom formats.

## 1.0.12.126

- Added `*-CosmosDbAttachment` cmdlets.

## 1.0.11.117

- Fixed `Get-CosmosDbDocument` returning (400) Bad Request error
  when executed with Query - See [Issue #22](https://github.com/PlagueHO/CosmosDB/issues/22).

## 1.0.10.108

- Added `*-CosmosDbDocument` cmdlets.

## 1.0.9.100

- Added `*-CosmosDbUserDefinedFunction` cmdlets.

## 1.0.8.91

- Added `*-CosmosDbStoredProcedure` cmdlets.

## 1.0.7.85

- Added `*-CosmosDbTrigger` cmdlets.

## 1.0.6.79

- Added `New-CosmosDbDatabase` and `Remove-CosmosDbDatabase` cmdlets.
- Improved unit tests.

## 1.0.5.73

- Added `Get-CosmosDbDatabase` and `Get-CosmosDbDatabaseResourcePath`
  cmdlets.

## 1.0.4.67

- Fixed bug in `New-CosmosDbConnection` detecting Azure connection.

## 1.0.4.63

- Fixed bug in `New-CosmosDbConnection` connecting to Azure and
  improved tests.
- Changed `New-CosmosDbAuthorizationToken` to replaced `Connection`
  parameter with `Key` and `KeyType` parameter.
- Fixed bug in `Invoke-CosmosDbRequest` that can cause connection
  object to be changed.

## 1.0.2.59

- Added `PartitionKey`, `OfferThroughput` and `OfferType` parameters to
  cmdlet `New-CosmosDBCollection`.
- Added support for retrieving key from Azure Management Portal.

## 1.0.2.53

- Updated manifest to show all cmdlets.

## 1.0.2.47

- Improved unit test coverage.
- Added cmdlet `Set-CosmosDBUser` for setting the user Id of an
  existing user.

## 1.0.1.40

- Minor bugfixes.
- Improved unit test coverage.

## 1.0.0.30

- Initial Release.









