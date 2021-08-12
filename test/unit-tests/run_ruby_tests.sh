
OLD_PATH=$(pwd)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH/../../source/plugins/ruby
ruby filter_cadvisor2mdm_tests.rb

cd $OLD_PATH
