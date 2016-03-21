#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use XML::LibXML qw(:libxml);

my $xml = q{
<record>
  <event>Men's 100m</event>
</record>
};
my $dom = XML::LibXML->load_xml(string => $xml);

my $record = $dom->documentElement;
my($event) = $record->getChildrenByTagName('event');
my $text = $event->firstChild;
$text->setData("Men's 100 metres");
$event->{type} = 'sprint';
say $dom->toString;

say '';

my $country = $dom->createElement('country');
$country->appendText('Jamaica');
$record->appendChild($country);

my $athlete = $dom->createElement('athlete');
$athlete->appendText('Usain Bolt');
$record->insertBefore($athlete, $country);

say $dom->toString;

say $dom->toString(1);

my $dom2 = $dom->cloneNode(1);

foreach my $node ($record->childNodes()) {
    $record->removeChild($node) if $node->nodeType != XML_ELEMENT_NODE;
}

say $dom->toString(1);

$dom = $dom2;

foreach ($dom->findnodes('//text()')) {
    $_->parentNode->removeChild($_) unless /\S/;
}

say $dom->toString(1);
