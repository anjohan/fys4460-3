program speedtest
    use utilities
    use percolation
    implicit none
    integer, parameter :: L = 10000
    integer :: number_of_labels
    logical, dimension(:,:), allocatable :: matrix
    integer, dimension(:,:), allocatable :: labelled_matrix
    integer :: spanning_label
    real(kind=dp), parameter :: p = 0.585
    real(kind=dp) :: t0,t1

    matrix = create_binary_matrix(p,L)

    call cpu_time(t0)
    call label(matrix, labelled_matrix, number_of_labels)
    call cpu_time(t1)

    write(*,*) "Time:", t1-t0
end program speedtest
