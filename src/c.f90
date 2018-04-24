program c
    use clusterlabelling

    integer :: i,j,k, fileunit
    integer, parameter :: L = 128, num_probabilities = 100, num_samples = 100
    real(kind=dp), dimension(:), allocatable :: probabilities, spanning_densities
    character(len=:), allocatable :: fmtstring, filename

    real(kind=dp), dimension(:,:), allocatable :: A
    real(kind=dp), dimension(:), allocatable :: b

    integer :: work, lwork, lda = num_probabilities, ldb = num_probabilities, info

    allocate(spanning_densities(num_probabilities))
    probabilities = linspace(pc, 1.2d0*pc, num_probabilities)
    fmtstring = "(f0.6,x,f0.6)"
    filename = "tmp/c_P.dat"

    open(newunit=fileunit, file=filename, status="replace")
    do i=1, num_probabilities
        spanning_densities(i) = spanning_density(probabilities(i), L, num_samples)
        write(unit=fileunit, fmt=fmtstring) probabilities(i), spanning_densities(i)
    end do
    close(unit=fileunit)

    write(*,*) "hello"
    allocate(A(num_probabilities,2))
    allocate(b(num_probabilities))

    write(*,*) "hello"
    A(:,1) = log10(probabilities - pc)
    A(:,2) = 1
    b(:) = log10(spanning_densities)

    write(*,*) shape(A)
    write(*,*) shape(b)
    call dgels("N",num_probabilities,2,1,A,lda,b,ldb,work,lwork,info) ! MORE ARGUMENTS PLEASE


end program c
