# awscli

The awscli package is a lightweight wrapper around the AWS CLI utility.
Most of the exported functions correspond directly to an AWS CLI command.

## Credentials

Since the R package just wraps the AWS CLI utility, it inherits the credentials processing of that same utility.
Thus, no additional credentials functions/initializations are needed, though the `configure_` family of functions can be used to help work with credentials.

## Use

In most cases, the R function just wraps the underlying AWS CLI command.
Since many AWS CLI calls can be configured to return a JSON document with a summary of the call results, the awscli package parses that returned document using `jsonlite::fromJSON()`.
