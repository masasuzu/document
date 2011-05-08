use strict;
use warnings;

use Net::SNMP;

# ipAdEntAddr => '.1.3.6.1.2.1.4.20.1.1'
my $OID = '.1.3.6.1.2.1.4.20.1.1';

my ($session, $error) = Net::SNMP->session(
    -hostname  => 'localhost',
    -community => 'private',
    -port      => 161,
    -timeout   => 10,
    -retries   => 1,
);

if (not defined($session)) {
    die "ERROR: $error.\n";
} else {
    # SEE http://search.cpan.org/~dtown/Net-SNMP-v6.0.1/lib/Net/SNMP.pm#get_table()_-_retrieve_a_table_from_the_remote_agent
    # get-next-requestとget-bulk-requestを駆使して、baseoid以下のオブジェクトをごっそり持ってくる
    my $response = $session->get_table(-baseoid => $OID)
         or die "cannot get snmp response. " . $session->error;
    $session->close();

    use YAML;
    print YAML::Dump($response);
}
#出力はこんな感じ
#---
#.1.3.6.1.2.1.4.20.1.1.127.0.0.1: 127.0.0.1
#.1.3.6.1.2.1.4.20.1.1.172.16.250.144: 172.16.250.144

