program f
    use utilities
    use clusterlabelling
    implicit none

    character(len=:), allocatable :: filename
    integer :: num_probabilities, num_samples, L, i, j, fileunit
    real(kind=dp), dimension(:), allocatable :: probabilities, cluster_number_densities, sizes

    L = 512
    num_samples = 100
    num_probabilities = 5
    probabilities = [0.45d0, 0.50d0, 0.54d0, 0.57d0, 0.58d0, &
                     0.60d0, 0.62d0, 0.65d0, 0.70d0, 0.75d0]
    num_probabilities = size(probabilities)

    open(newunit=fileunit, file="tmp/f_p.dat", status="replace")
    do i=1, num_probabilities
        write(unit=fileunit, fmt="(f0.4)") probabilities(i)
    end do
    close(unit=fileunit)

    !$omp parallel do private(sizes, cluster_number_densities)
    do i = 1, num_probabilities
        associate(p => probabilities(i))
            call cluster_number_density(p, L, num_samples, sizes, cluster_number_densities)
            filename = "tmp/f_p_" // stringfromint(i) // ".dat"
            open(unit=fileunit, file=filename, status="replace")
            do j = 1, size(sizes)
                write(unit=fileunit,fmt=*) sizes(j), cluster_number_densities(j)
            end do
            close(unit=fileunit)
        end associate
    end do
    !$omp end parallel do



end program f
