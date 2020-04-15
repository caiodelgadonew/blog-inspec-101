title "Tests for Vault application"

control "Vault Binary" do
  impact "high"
  title "Vault Binary"
  desc "Test if Binary of Vault its installed and working"
  describe file("/usr/local/bin/vault") do
    it { should exist }
    it { should be_file }
  end
  describe command("vault") do
    it { should exist } 
  end
  describe command("vault --version") do
    its("stdout") { should cmp > "Vault v1" }
  end 
end

control "Mysql Service" do 
  impact "critical"
  title "Mysql Service"
  desc "Test if Mysql binary is present, if the server is running and listening"
  describe service("mysqld") do
    it { should be_enabled }
    it { should be_running }
  end
  describe package("mariadb-server") do
    it { should be_installed }
    its("version") { should cmp > "1:10" }
  end
  describe port("3306") do
    it { should be_listening }
    its("processes") { should include "mysqld" }
  end 
end

control "Vault Server" do
  impact "critical"
  title "Vault Server"
  desc "Test if vault server is installed, running and listening, and its config file content is correct"
  describe service("vault") do
    it { should be_enabled }
    it { should be_running }
  end
  describe port("8200") do
    it { should be_listening }
    its("processes") { should include "vault" }
  end
  describe file("/etc/vault.d/config.hcl") do 
    it { should be_file }
    it { should be_owned_by "vault" }  
    its("content") { should include 'storage "mysql"' }
    its("content") { should include 'username = "vaultuser"' }
    its("content") { should include 'database = "vault"' }
    its("content") { should include 'listener "tcp"' }
    its("content") { should include '10.10.10.10:8200' }
  end
end

