module stuffmod
    implicit none
    contains
        elemental function testfunc(a,b) result(x)
            integer, intent(in) :: a,b
            integer :: x
            x = a*b
        end function
end module

program test
    use utilities
    use percolation
    use stuffmod
    implicit none

    write(*,*) testfunc(3,[4,5,6])
    write(*,*) testfunc([1,2,3],4)
    write(*,*) testfunc([1,2,3],[4,5,6])

end program test
