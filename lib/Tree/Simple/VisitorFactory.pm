
package Tree::Simple::VisitorFactory;

use strict;
use warnings;

our $VERSION = '0.01';

sub new { 
    my ($class) = @_;
    return bless \$class;
}

sub get {
    my ($class, $visitor) = @_;
    (defined($visitor)) || die "Insufficient Arguments : You must specify a Visitor to load";
    $visitor = "Tree::Simple::Visitor::$visitor";
    eval "require $visitor";
    die "Illegal Operation : Could not load Visitor ($visitor) because $@" if $@;
    return $visitor->new();
}

*getVisitor = \&get;

1;

__END__

=head1 NAME

Tree::Simple::VisitorFactory - A factory object for dispensing Visitor objects

=head1 SYNOPSIS

  use Tree::Simple::VisitorFactory;
  
  my $tf = Tree::Simple::VisitorFactory->new();
  
  my $visitor = $tf->get("PathToRoot");
  
  # or call it as a class method
  my $visitor = Tree::Simple::VisitorFactory->getVisitor("PathToRoot");

=head1 DESCRIPTION

This object is really just a factory for dispensing Tree::Simple::Visitor::* objects. It is not required to use this package in order to use all the Visitors, it is just a somewhat convienient way to avoid having to type thier long class names. 

I considered making this a Singleton, but I did not because I thought that some people might not want that. I know that I am very picky about using Singletons, especially in multiprocess environments like mod_perl, so I implemented the smallest instance I knew how to, and made sure all other methods could be called as class methods too. 

=head1 METHODS

=over 4

=item B<new>

Returns an minimal instance of this object, basically just a reference back to the package (literally, see the source if you care).

=item B<get ($visitor_type)>

Attempts to load the C<$visitor_type> and returns an instance of it if successfull. If no C<$visitor_type> is specified an exception is thrown, if C<$visitor_type> fails to load, and exception is thrown.

=item B<getVisitor ($visitor_type)>

This is an alias of C<get>.

=back

=head1 TO DO

Obviously this is not an exhaustive collection of Visitor objects, many more can be written. These were a basic set which I find myself using quite often. A few other possible ideas are:

=over 4

=item B<In-order traversal>

I scrapped this idea since in-order traversal only makes sense for binary trees and Tree::Simple is an n-ary tree by nature. However, since there is nothing stoping you from using a Tree::Simple object as a binary tree, then there may be a use for this. For now though, I am leaving it aside until I decide the best way to handle it.

=item B<Generalized search>

I have been thinking about having a generalized tree search visitor, but I am still working out how the interface might work. Should I take parameters, and parse/process them? Should I ask the user to provide a predicate to test nodes with? Do I use the node filter mechanism with that? Etc, etc, etc. It would of course allow for different traversal types, but that then got me started thinking about more search oriented traversal algorithims like B<A*> and such. In the end however, this is not something I am very experienced, so I am leaving it aside for now.

=item B<Syntax Tree specific>

I was considering a Visitor which would take a syntax tree of an expression and be able to convert it to the different notations; prefix, postfix, infix. This however, would require a special purpose tree, which brings me to the same prediciment of the in-order traversal and how to determine that the tree given fits that tree type.

=item B<Tree balancing>

This is a much more complex idea, and I am not even sure a Visitor is an appropriate way to implement this. 

=back

=head1 BUGS

None that I am aware of. Of course, if you find a bug, let me know, and I will be sure to fix it. 

=head1 CODE COVERAGE

I use B<Devel::Cover> to test the code coverage of my tests, below is the B<Devel::Cover> report on this module test suite.

 ------------------------------------------------------ ------ ------ ------ ------ ------ ------ ------
 File                                                     stmt branch   cond    sub    pod   time  total
 ------------------------------------------------------ ------ ------ ------ ------ ------ ------ ------
 /Tree/Simple/Visitor/BreadthFirstTraversal.pm           100.0   66.7   77.8  100.0  100.0    2.2   92.6
 /Tree/Simple/Visitor/FindByPath.pm                      100.0   62.5   77.8  100.0  100.0    1.8   91.7
 /Tree/Simple/Visitor/GetAllDescendents.pm               100.0  100.0   86.7  100.0  100.0    1.8   97.2
 /Tree/Simple/Visitor/PathToRoot.pm                      100.0   50.0   75.0  100.0  100.0    1.4   89.2
 /Tree/Simple/Visitor/PostOrderTraversal.pm              100.0   66.7   58.3  100.0  100.0    2.2   87.7
 /Tree/Simple/VisitorFactory.pm                          100.0  100.0    n/a  100.0  100.0    0.5  100.0
 /t/10_Tree_Simple_VisitorFactory_test.t                 100.0    n/a    n/a  100.0    n/a    6.1  100.0
 /t/20_Tree_Simple_Visitor_PathToRoot_test.t             100.0    n/a    n/a  100.0    n/a   19.1  100.0
 /t/30_Tree_Simple_Visitor_FindByPath_test.t             100.0    n/a    n/a  100.0    n/a   17.7  100.0
 /t/40_Tree_Simple_Visitor_GetAllDescendents_test.t      100.0    n/a    n/a  100.0    n/a   19.9  100.0
 /t/50_Tree_Simple_Visitor_BreadthOrderTraversal_test.t  100.0    n/a    n/a  100.0    n/a   13.8  100.0
 /t/60_Tree_Simple_Visitor_PostOrderTraversal_test.t     100.0    n/a    n/a  100.0    n/a   13.5  100.0
 ------------------------------------------------------ ------ ------ ------ ------ ------ ------ ------
 Total                                                   100.0   70.8   75.4  100.0  100.0  100.0   96.1
 ------------------------------------------------------ ------ ------ ------ ------ ------ ------ ------

=head1 SEE ALSO

These Visitor classes are meant to work with B<Tree::Simple> hierarchies, you should refer to that module for more information.

=head1 AUTHOR

stevan little, E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

