



# Terraformのコマンド

terraformは様々なコマンドを受け付けます。
`terraform` `terraform init` `terraform plan`

terraformのコマンドは別名、`terraform CLI`と呼ばれていますが、これは**terraformが扱うそのほかのプロバイダーが用いるコマンドと明確に区別するためです。**


## terraformのコマンドヘルプの見方

terraformのコマンドを確認するためには、`terraform`と入力します。

つぎの実行結果は2022年12月の実行結果ですが、**terraformは破壊的なバージョン変更（急に今までのコマンドやシンタックスが使えなくなること）が発生する**ので、ドキュメントは定期的に確認することをお勧めしますし、次の実行結果は一月後には変更されている可能性もあります。

```
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.
```

また、特定のコマンドについてのヘルプを参照する場合には、`terraform <command> -help`と入力します。

「validate」コマンドについてのヘルプを参照する場合は、`terraform validate -help`と入力しましょう。


## terraformの実行方法

Terraformを実行するためには、`.tf`ファイルが格納されたディレクトリに`cd`コマンドで移動する必要があります。


### terraformでパス指定をして実行

Terraformでは、実行するコマンドの前にパスを指定するオプションが存在します。

```sh
terraform -chdir=environments/production apply
```


#### -chdir以外のディレクトリを参照する場合

コマンドの実行とは関係ありませんが、
`path.cwd`や`path.root`を使用することで、-chdirにより上書きされたパスではなく、terraformのコマンドを実行した場所を参照することができます。







title:terraformでパスを指定してコマンドを実行する


category_script:True


redirect:https://minegishirei.hatenablog.com/entry/2023/01/27/121646

