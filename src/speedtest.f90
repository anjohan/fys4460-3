program speedtest
    use clusterlabeling
    implicit none
    integer, parameter :: L = 10000
    integer :: number_of_labels
    logical, dimension(:,:), allocatable :: matrix
    integer, dimension(:,:), allocatable :: labeled_matrix
    real, dimension(L,L) :: random_matrix
    real, parameter :: p = 0.5
    integer :: i,j
    real :: t0,t1

    character(len=:), allocatable :: intfmtstring, logicalfmtstring
    character(len=20) :: Lstring
    write(unit=Lstring,fmt="(i0)") L
    intfmtstring = '('//trim(Lstring)//'i10)'
    logicalfmtstring = '('//trim(Lstring)//'L3)'

    allocate(labeled_matrix(L,L))
    labeled_matrix(:,:) = 0

    call random_seed()
    call random_number(random_matrix)

    matrix = random_matrix < p

    call cpu_time(t0)
    call label(matrix, labeled_matrix, number_of_labels)
    call cpu_time(t1)

    ! write(*, fmt=logicalfmtstring) labeled_matrix
    print *
    ! write(*, fmt=intfmtstring) labeled_matrix

    print *, "Labeling time = ", t1-t0, " s"

end program speedtest
