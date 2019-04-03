# # encoding: utf-8

# Inspec test for recipe chef-client-hab-distro::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('chef') do
  it { should_not be_installed }
end

# TODO: Update this to be Windows-Friendly
describe command('/usr/bin/hab pkg list --all') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /core\/hab/ }
  its('stdout') { should match /chef\/chef-client/ }
end
