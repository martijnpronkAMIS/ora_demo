#
# Install librarian puppet. We need this to download the correct set of puppet modules
#
echo 'Installing required gems'
/opt/puppetlabs/puppet/bin/gem install activesupport:4.2.7.1 librarian-puppet awesome_print --no-rdoc --no-ri
yum install git unzip net-tools -y

echo 'Installing required puppet modules'
cd /vagrant
cp -r Puppetfile manifests /etc/puppetlabs/code/environments/production
ln -s /vagrant/modules/* /etc/puppetlabs/code/environments/production/modules/
cd /etc/puppetlabs/code/environments/production

/opt/puppetlabs/puppet/bin/librarian-puppet install --verbose

#
# Setup hiera search and backend. We need this to config our systems
#
echo 'Setting up hiera directories'

dirname=/etc/puppetlabs/code/environments/production/hieradata
if [ -d $dirname ]; then
  rm -rf $dirname
else
  rm -f $dirname
fi
ln -sf /vagrant/hieradata /etc/puppetlabs/code/environments/production

cp /vagrant/hiera.yaml /etc/puppetlabs/code/environments/production/
