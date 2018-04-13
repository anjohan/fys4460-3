program test
    implicit none
    character(len=:), allocatable :: string
    character(len=20) :: s1
    integer :: n = 5
    ! allocate(string, source="hei")
    write(unit=s1, fmt="(i0)") n
    print *, s1, len(s1), trim(s1), len_trim(s1)
    write(*, fmt="(A)") '('//trim(s1)//'i0)'
end program test
