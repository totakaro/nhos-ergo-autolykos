#!/bin/sh

# NHOS Ergo Autolykos (unofficial)
# by @totakaro
# MIT License

# WARNING: Need to stop your rig manually on Nicehash App or website first

# Makes sure this script is executed manually
if ! [ -f /tmp/ergo.pid ]; then
  touch /tmp/ergo.pid
  echo "First time execution. Please execute it again"
  exit 1
fi

# Check root https://stackoverflow.com/a/18216122
if [ `id -u` -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Check if miner is running (please stop your rig first on Nicehash Web or App manually)
if pgrep -x "nbminer" > /dev/null; then
  echo "Miner is running, stop it first on nicehash web or app"
  exit 1
fi

if ! [ -f /opt/nbminer/nbminer.exe ]; then
  mv -v /opt/nbminer/nbminer /opt/nbminer/nbminer.exe 
fi

cat <<-'ERGO' > /opt/nbminer/nbminer
#!/bin/sh
BTC=xxxxxxxxxxxxxxxxxxxxxxxx # Setup your address here
LOCATION=usa-east # Setup your location: eu-north eu-west usa-east or usa-west https://www.nicehash.com/blog/post/new-mining-locations-are-now-available
/opt/nbminer/nbminer.exe -a ergo -o stratum+tcp://autolykos.$LOCATION.nicehash.com:3390 -u $BTC\$$HOSTNAME --no-watchdog --api 127.0.0.1:4000
ERGO

chmod +x /opt/nbminer/nbminer

echo "Done!"
echo "Remember to start your rig on Nicehash Web or App"

