sudo apt-get update -y > /dev/null && sudo apt-get upgrade -y > /dev/null
sudo apt-get install -y git > /dev/null
sudo apt-get install -y build-essential > /dev/null
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev > /dev/null
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
LINE='export PATH="$HOME/.rbenv/bin:$PATH"\n'
FILE=~/.bashrc
sudo grep -qF "$LINE" "$FILE" || sudo printf "$LINE" >> "$FILE"
LINE='eval "$(rbenv init -)"\n'
FILE=~/.bashrc
sudo grep -qF "$LINE" "$FILE" || sudo printf "$LINE" >> "$FILE"
source ~/.bashrc
sudo -H -u ubuntu bash -i -c 'rbenv rehash'
sudo -H -u ubuntu bash -i -c 'mkdir -p "$(rbenv root)"/plugins'
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
#exec $SHELL
sudo -H -u ubuntu bash -i -c 'rbenv install 2.3.3'
sudo -H -u ubuntu bash -i -c 'rbenv global 2.3.3'
sudo -H -u ubuntu bash -i -c 'ruby -v'
sudo -H -u ubuntu bash -i -c 'gem install bundler'
sudo -H -u ubuntu bash -i -c 'rbenv rehash'

