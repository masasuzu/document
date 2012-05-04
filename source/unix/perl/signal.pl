use strict;
use warnings;
use feature qw( say state );

sub signal_defined_proc {
    my $cb = shift;
    local $SIG{HUP} = sub {
        warn '握りつぶすよ';
    };

    local $SIG{INT} = sub {
        warn '1秒待って死ぬよ';
        sleep 1;
        die  'さようなら';
    };

    local $SIG{ALRM} = sub {
        warn 'アラームを受け取ったよ';
    };
    $cb->();
}

sub normal_proc {
    my $cb = shift;
    $cb->();
}

my $cb = sub {
    state $i;
    alarm 5;
    say ++$i and sleep 1 for 1..10;
};

say 'シグナル定義した場合';
signal_defined_proc($cb);

say 'デフォルトの場合';
normal_proc($cb);
