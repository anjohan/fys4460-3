program iprogram
    use utilities
    use clusterlabelling
    implicit none

    integer :: num_samples, i, j, spanning_label, num_Ls, num_clusters, fileunit
    logical, dimension(:,:), allocatable :: matrix
    integer, dimension(:,:), allocatable :: label_matrix
    integer, dimension(:), allocatable :: Ls
    real(kind=dp) :: D, const, tmpM
    real(kind=dp), dimension(:), allocatable :: Ms_approx, Ms

    num_samples = 200
    Ls = 2**[(i, i=4, 11)]
    num_Ls = size(Ls)
    allocate(Ms(num_Ls))
    Ms = 0

    do i = 1, num_Ls
        associate(L => Ls(i), M => Ms(i))
            tmpM = 0
            !$omp  parallel do &
            !$omp& private(matrix, label_matrix, num_clusters, spanning_label) &
            !$omp& reduction(+:tmpM)
            do j = 1, num_samples
                matrix = create_binary_matrix(pc, L)
                call label(matrix, label_matrix, num_clusters)
                spanning_label = find_spanning_cluster(label_matrix, num_clusters)
                tmpM = tmpM + count(label_matrix == spanning_label)
            end do
            !$omp end parallel do
            M = tmpM
        end associate
    end do

    Ms = Ms/num_samples

    call linfit(log(1.0d0*Ls), log(Ms), D, const)
    Ms_approx = exp(const) * Ls**D

    open(newunit=fileunit, file="tmp/i.dat", status="replace")
    do i = 1, num_Ls
        write(unit=fileunit, fmt=*) Ls(i), Ms(i), Ms_approx(i)
    end do
    close(unit=fileunit)

    open(newunit=fileunit, file="tmp/i_D.dat", status="replace")
    write(unit=fileunit, fmt="(f0.3)") D
    close(unit=fileunit)

end program iprogram
