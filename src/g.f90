program g
    use utilities
    use percolation
    implicit none

    character(len=:), allocatable :: filename
    integer :: num_samples, i, j, fileunit, L, firstindex, lastindex, num_sizes
    real(kind=dp), dimension(:), allocatable :: cluster_number_densities, sizes
    real(kind=dp) slope, const, tau

    num_samples = 1000

    do i = 4, 9
        L = 2**i
        call cluster_number_density(pc, L, num_samples, sizes, cluster_number_densities)
        num_sizes = size(sizes)


        filename = "tmp/g_" // stringfromint(i) // ".dat"
        open(unit=fileunit, file=filename, status="replace")
        do j = 1, num_sizes
            write(unit=fileunit,fmt=*) sizes(j), cluster_number_densities(j)
        end do
        close(unit=fileunit)
    end do

    firstindex = int(0.2*num_sizes + 0.5)
    lastindex  = int(0.8*num_sizes + 0.5)

    call linfit(log(sizes(firstindex:lastindex)), log(cluster_number_densities(firstindex:lastindex)), slope, const)

    tau = -slope

    filename = "tmp/g_9_approx.dat"
    open(unit=fileunit, file=filename, status="replace")
    do j = 1, num_sizes
        write(unit=fileunit, fmt=*) sizes(j), sizes(j)**slope * exp(const)
    end do
    close(unit=fileunit)

    filename = "tmp/g_9_tau.dat"
    open(unit=fileunit, file=filename, status="replace")
    write(unit=fileunit, fmt="(f0.3)") tau
    close(unit=fileunit)

end program g
