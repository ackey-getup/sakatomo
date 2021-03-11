server '3.130.10.219', user: 'ec2-user', roles: %w{app db web}

# CircleCIのGUIで設定した環境変数を使ってSSH接続
set :ssh_options, {
  port: 22,
  user: 'ec2-user',
  keys: ['~/.ssh/sakatomo_rsa'],
  forward_agent: true,
  auth_methods: %w[publickey]
}