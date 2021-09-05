unit nakedSingle;

interface
uses types, auxiliary;
procedure SolveCell (var grid : TIntegerGrid; InputHint : TStringGrid);

// Naked single = cell with only one hint

implementation

procedure SolveCell (var grid : TIntegerGrid; InputHint : TStringGrid);
var x, y : integer;
begin
    for y := 0 to 8 do
        for x := 0 to 8 do
            if (grid[y, x] = 0) and (length(InputHint[y, x]) = 1) then
            begin
                grid[y, x] := SBA_StrToInt(InputHint[y, x]);
                
                if VERBOSE then
                    writeln('Set (', y, ',', x, ') as ', InputHint[y, x], ' by naked single');
            end;
end;

end.