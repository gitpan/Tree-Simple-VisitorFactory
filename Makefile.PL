use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Tree::Simple::VisitorFactory',
    VERSION_FROM => 'lib/Tree/Simple/VisitorFactory.pm', 
    PREREQ_PM    => {
        'Test::More'      => 0.47,
        'Test::Exception' => 0.15,
        'Tree::Simple'    => 1.06
    }
);
