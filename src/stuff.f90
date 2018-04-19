program test
    use utilities
    implicit none
    character(len=:), allocatable :: string

    string = stringfromint(123)
    print *, string

    write(*,*) linspace(1.0d0,3.0d0,5)
end program test
