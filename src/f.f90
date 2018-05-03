program f
    use utilities
    use clusterlabelling
    implicit none

    integer :: num_probabilities, num_samples, L, i, j, fileunit
    real(kind=dp), dimension(:), allocatable :: probabilities, cluster_number_densities, sizes

    L = 512
    num_samples = 500
    num_probabilities = 4
    probabilities = linspace(0.9d0*pc, 1.1d0*pc, num_probabilities)

    open(newunit=fileunit, file="tmp/f_p.dat", status="replace")
    do i=1, num_probabilities
        write(unit=fileunit, fmt="(f0.4)") probabilities(i)
    end do
    close(unit=fileunit)

    do i = 1, num_probabilities
        associate(p => probabilities(i))
            call cluster_number_density(p, L, num_samples, sizes, cluster_number_densities)
        end associate
    end do



end program f
