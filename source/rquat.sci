function q = rquat(t, n)
    // Creates a rotation quaternion.
    //
    // Syntax
    //   q = rquat(radians, axis)
    //
    // Parameters
    // q: quaternion, the rotation quaternion to be created
    // radians: real, the angle of rotation in radians
    // axis: unit vector, the axis of rotation
    //
    // Description
    // Generates a quaternion that represents a rotation in 3D space. A rotation is represented by an axis and an angle.
    //
    // Examples
    // r = rquat(%pi/2, [1, 0, 0])
    // y = qrotate([0, 0, 1], r) // y is [0, 1, 0], which is the vector [0, 0, 1] rotated by the x axis %pi/2 radians
    //
    // See also
    //  rotation_quaternion
    //  quat
    //  rquatd
    //  qrotate
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        check_args("rquat(radians, axis)", t, %real, n, %vector)

        if length(n) ~= 3 then
            error("rquat(radians, axis): Argument checking failed for argument 2. The axis must have 3 components.")
        elseif get_type(n(1)) ~= %real || get_type(n(2)) ~= %real || get_type(n(3)) ~= %real then
            error("rquat(radians, axis): Argument checking failed for argument 2. The axis must have real components.")
        elseif abs(norm(n) - 1) > %epsilon then
            warning("rquat(radians, axis): Normalizing vector. The axis must be a UNIT vector.")
            n = n / norm(n)
        end
    end

    a = .5*t; q = tlist(["quat", "real", "imag"], cos(a), sin(a) * n)
endfunction