# LSHTM Plugin Options

# Google maps plugin for recollect geographical location metadata entry 
$c->{plugins}{"InputForm::Surround::Map_surround"}{params}{disable} = 0;

# for further devlopment. Eprints fields can be specified for the map popup info window
# $c->{map_information_fields} = [qw/ title abstract uri eprintid /];

# set the required number of eprint markers
$c->{eprints_loc_limit} = 30;

# Trigger to load the google maps apiv3 with drawing and location libraries enabled
# and the jQuery 1.11.0 min library + jQueryUI

$c->add_trigger( $EPrints::Plugin::Stats::EP_TRIGGER_DYNAMIC_TEMPLATE, sub
{
        my( %args ) = @_;

        my( $repo, $pins ) = @args{qw/ repository pins/};

        my $protocol = $repo->get_secure ? 'https':'http';

        my $head = $repo->make_doc_fragment;

        print STDERR "in maps trigger\n";
        $head->appendChild( $repo->make_javascript( undef,
                src =>"$protocol://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"
        ) );

        $head->appendChild( $repo->make_javascript( undef,
                src=>"$protocol://ajax.googleapis.com/ajax/libs/jqueryui/1.11.0/jquery-ui.min.js"

        ) );

        $head->appendChild( $repo->make_javascript( undef,
                src => "$protocol://maps.googleapis.com/maps/api/js?libraries=drawing,places&key=AIzaSyBoGhuQDxdI-KpbzZKzxNoZvnejwPk5te0"
        ) );

        $head->appendChild( $repo->make_javascript( undef,
                src => "$protocol://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js",
                integrity => "sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS",
                crossorigin => "anonymous"
        ) );

        $pins->{"utf-8.map_view"} = "" if( !exists $pins->{"utf-8.map_view"} );
        my $base_url = $c->{base_url};
        $pins->{"utf-8.map_view"} .= <<MapView;

<!-- MapView -->
<li>
<a id = "ep_map_location" href="$base_url/cgi/MapView">Location
</a>
</li>

MapView

        if( defined $pins->{'utf-8.head'} )
        {
                $pins->{'utf-8.head'} .= $repo->xhtml->to_xhtml( $head );
        }

        if( defined $pins->{head} )
        {
                $head->appendChild( $pins->{head} );
                $pins->{head} = $head;
        }
        else
        {
                $pins->{head} = $head;
        }

        return EP_TRIGGER_OK;
} );

