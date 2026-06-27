const std = @import("std");
const princ = @import("root.zig");

pub fn main() !void {
    inline for (@typeInfo(princ.Color).@"enum".fields) |field| {
        const color: princ.Color = @enumFromInt(field.value);
        princ.princ(color, "color {d:3} {s}\n", .{ field.value, field.name });
    }
}
