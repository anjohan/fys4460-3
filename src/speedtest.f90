program speedtest
    use clusterlabeling
    use utilities
    implicit none
    integer, parameter :: L = 10
    integer :: number_of_labels
    logical, dimension(:,:), allocatable :: matrix
    integer, dimension(:,:), allocatable :: labeled_matrix
    real, parameter :: p = 0.5
    real :: t0,t1

    matrix = create_binary_matrix(p,L)

    call cpu_time(t0)
    call label(matrix, labeled_matrix, number_of_labels)
    call cpu_time(t1)

    write(*,*) "Binary matrix:"
    write(*, fmt='('//stringfromint(L)//'L4)') matrix

    write(*,*) "Labeled matrix:"
    write(*, fmt='('//stringfromint(L)//'i4)') labeled_matrix

    write(*,*) "Spanning cluster:", find_spanning_cluster(labeled_matrix, number_of_labels)

    print *, "Labeling time = ", t1-t0, " s"

end program speedtest
