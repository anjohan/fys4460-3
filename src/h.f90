program h
    use clusterlabelling
    use utilities
    implicit none
    integer :: num_probabilities, num_sizes, num_samples, L, n_unit, s_xi_unit, i, j, p_unit
    real(kind=dp), dimension(:), allocatable :: sizes, cluster_number_densities, probabilities, s_xi, n_pc, &
                                                s_xi_approx
    real(kind=dp) slope, const, sigma
    character(len=:), allocatable :: filename

    num_samples = 2000
    L = 512

    probabilities = [0.45, 0.50, 0.54, 0.57, 0.58]
    num_probabilities = size(probabilities)
    open(newunit=p_unit, file="tmp/h_p.dat", status="replace")
    do i = 1, num_probabilities
        write(unit=p_unit, fmt="(f0.3)") probabilities(i)
    end do
    close(unit=p_unit)

    allocate(s_xi(num_probabilities))

    call cluster_number_density(pc, L, num_samples, sizes, n_pc)

    open(newunit=s_xi_unit, file="tmp/h_s_xi.dat", status="replace")

    do i = 1, num_probabilities
        associate(p => probabilities(i))
            call cluster_number_density(p, L, num_samples, sizes, cluster_number_densities)
            num_sizes = size(sizes)
            do j = 1, num_sizes
                if(cluster_number_densities(j) <= 0.5*n_pc(j)) then
                    s_xi(i) = sizes(j)
                    write(unit=s_xi_unit, fmt=*) sizes(j), cluster_number_densities(j)
                    exit
                end if
            end do

            filename = "tmp/h_" // stringfromint(i) // ".dat"
            open(newunit=n_unit, file=filename, status="replace")
            do j = 1, num_sizes
                write(unit=n_unit, fmt=*) sizes(j), cluster_number_densities(j)
            end do
            close(unit=n_unit)
        end associate
    end do
    close(unit=s_xi_unit)

    call linfit(log(abs(probabilities - pc)), log(s_xi), slope, const)
    sigma = -1/slope

    s_xi_approx = exp(const) * abs(probabilities - pc)**slope
    open(newunit=s_xi_unit, file="tmp/h_s_xi2.dat", status="replace")
    do i = 1, num_probabilities
        write(unit=s_xi_unit, fmt=*) probabilities(i), s_xi(i), s_xi_approx(i)
    end do
    close(unit=s_xi_unit)

    open(newunit=s_xi_unit, file="tmp/h_sigma.dat", status="replace")
    write(unit=s_xi_unit, fmt="(f0.3)") sigma
    close(unit=s_xi_unit)
end program h
