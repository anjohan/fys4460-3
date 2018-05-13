program verification
    use percolation
    use utilities
    implicit none
    integer, parameter :: L = 6
    integer :: number_of_labels, i,j
    logical, dimension(:,:), allocatable :: matrix
    integer, dimension(:,:), allocatable :: labelled_matrix
    integer :: spanning_label
    real(kind=dp), parameter :: p = 0.585
    real(kind=dp) :: t0,t1

    matrix = create_binary_matrix(p,L)

    write(*,fmt="(a)") "Binary matrix:"
    do i=1,L
        write(*, fmt='('//stringfromint(L)//'L4)') matrix(i,:)
    enddo

    call cpu_time(t0)
    call label(matrix, labelled_matrix, number_of_labels)
    call cpu_time(t1)

    write(*,fmt="(a)") "Labelled matrix:"
    do i=1,L
        write(*, fmt='('//stringfromint(L)//'i4)') labelled_matrix(i,:)
    enddo

    spanning_label = find_spanning_cluster(labelled_matrix, number_of_labels)
    write(*,fmt="(ai0)") "Spanning cluster: ", spanning_label
    write(*,fmt="(ai0)") "Spanning cluster area: ", count(labelled_matrix == spanning_label)

end program verification
