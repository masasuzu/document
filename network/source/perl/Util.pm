#App::MadEye::Util;

sub snmp_session {
    my ($agent, $host, $callback, ) = @_;

    my $community = $agent->config->{config}->{community} or die "missing community";
    my $port      = $agent->config->{config}->{port}    || 161;
    my $timeout   = $agent->config->{config}->{timeout} || 10;
    my $retries   = $agent->config->{config}->{retries} || 1;

    my ($session, $error) = Net::SNMP->session(
        -hostname  => $host,
        -community => $community,
        -port      => $port,
        -timeout   => $timeout,
        -retries   => $retries,
    );

    if (not defined($session)) {
        die "ERROR: $error.\n";
    } else {
        my $response = $callback->($session);
        $session->close();
        return $response;
    }
}
