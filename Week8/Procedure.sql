-- write a procedure that check the prime number
-- input: number
-- output: true or false
-- procedure:

create procedure check_prime(@number int)
begin
    if @number = 1 then
        return 0;
    elseif @number = 2 then
        return 1;
    else
        for i = 2 to @number - 1
        begin
            if @number % i = 0 then
                return 0;
        end
        return 1;
    end
end

