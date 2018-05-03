program test
    use utilities
    use clusterlabelling
    implicit none
    character(len=:), allocatable :: string
    integer, dimension(:,:), allocatable :: intarray
    integer :: i,j

    string = stringfromint(123)
    print *, string

    write(*,*) linspace(1.0d0,3.0d0,5)

    allocate(intarray(10,2))
    intarray(:,1) = [ (i, i=1,20,2) ]
    intarray(:,2) = [ (i, i=2,20,2) ]

    write(*,fmt="(*(i0,x,i0,/))") [ ([intarray(i,1),intarray(i,2)], i=1,10) ]
    write(*,*) spanning_probability(0.59d0,10,100)

    call cluster_number_density(1.0d0,5,1)
end program test
