function r = %s_a_quat(s, q)
    // Complex-quaternion and vector-quaternion addition.
    //
    // Syntax
    //   result = %s_a_quat(s, q)
    //
    // Parameters
    // result: quaternion, the sum of the operands
    // s: complex|vector, the first operand
    // q: quaternion, the second operand
    //
    // Description
    // The sum of a complex number or a vector with a quaternion is defined as the quaternion which has each component equal to the sum of the operands components.
    //
    // <latex>$(A + B\ i) + (a,\ b,\ c,\ d) = (A+a,\ B+b,\ c,\ d)$</latex>
    //
    // <latex>$[B,\ C] + (a,\ b,\ c,\ d) = (a,\ B+b,\ C+c,\ d)$</latex>
    //
    // <latex>$[B,\ C,\ D] + (a,\ b,\ c,\ d) = (a,\ B+b,\ C+c,\ D+d)$</latex>
    //
    // <latex>$[A,\ B,\ C,\ D] + (a,\ b,\ c,\ d) = (A+a,\ B+b,\ C+c,\ D+d)$</latex>
    //
    // Examples
    // q = quat(-1, -1, -1, -1)
    // 1 + q // quat(0, -1, -1, -1)
    // (1 + %i) + q // quat(0, 0, -1, -1)
    // [1, 1] + q // quat(-1, 0, 0, -1)
    // [1, 1, 1] + q // quat(-1, 0, 0, 0)
    // [1, 1, 1, 1] + q // quat(0, 0, 0, 0)
    //
    // See also
    //  quat
    //  %quat_a_s
    //  %quat_a_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        if get_type(s).data(2) > %vector.data(2) then
            error("%s_a_quat(s, q): Argument checking failed for argument 1. Cannot add a matrix/hypermatrix with a quaternion.")
        end
    end

    select length(s)
    case 1 then
        r = tlist(["quat", "real", "imag"], real(s) + q.real, [imag(s), 0, 0] + q.imag)
    case 2 then
        r = q; r.imag = [s(1:2), 0] + r.imag
    case 3 then
        r = q; r.imag = s + r.imag
    case 4 then
        r = tlist(["quat", "real", "imag"], s(1) + q.real, s(2:4) + q.imag)
    else
        error("%s_a_quat(s, q): Argument checking failed for argument 1. Cannot add a vector with size greater than 4 with a quaternion.")
    end
endfunction
