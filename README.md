# ec2でもhttps通信したいためのgateway
- endpoint単位で作るのが理想だが手間なのでlambdaで分岐する

# 環境
- amazon linux2
- terraform v0.13.0

# terraform勉強中
- api-gateway&lambdaを専用vpcで動かす
- その専用vpcは別vpcとピアリング接続する
- 単一ソースファイルからのみの対応

# 別リポジトリをmoduleとして使用
- そっちが変わったらこっちも変わる
- git submodule

# コマンド
## terraform
- terraform init
- terraform plan
- terraform apply
- terraform destroy
## git submodule
- クローンと同時に初期化
- git clone --recursive git://github.com/foo/bar.git
- 更新されたsubmoduleの取り込み
- git submodule update --remote --merge
- git add . (submoduleのソースもコミット対象っぽい)
- git push --recurse-submodules=check

# input
- project_name
## interited from apigw-lambda
- source_file
- output_path
- runtime
- handler
## interited from vpc
- vpcのcidr
- route tableのcidr
- subnetのcidr

# todo
- cloudwatchとか
- コンソールで手動デプロイが必要
    - /v1とかでhttps://~.amazonaws.com/v1/apになる
