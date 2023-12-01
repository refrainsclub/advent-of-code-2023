const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day01.txt");

pub fn partOne() !u32 {
    var rollingSum: u32 = 0;

    var lines = splitAny(u8, data, "\n");
    while (lines.next()) |line| {
        var first: ?u8 = null;
        var last: ?u8 = null;

        const chars = std.mem.bytesAsSlice(u8, line);
        for (chars) |c| {
            if (std.ascii.isDigit(c)) {
                if (first == null) {
                    // subtract 0 char to convert ANSI decimal representation to real num
                    first = c - '0';
                } else {
                    last = c - '0';
                }
            }
        }

        // some lines only have one number
        if (last == null) {
            last = first.?;
        }

        // multiply by 10 to put first in tens column
        const value = first.? * 10 + last.?;
        rollingSum += value;
    }

    return rollingSum;
}

pub fn partTwo() !u32 {
    const nums = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };
    var rollingSum: u32 = 0;

    var lines = splitAny(u8, data, "\n");
    while (lines.next()) |line| {
        var first: ?u8 = null;
        var last: ?u8 = null;

        for (line, 0..) |c, i| {
            // check for text num
            for (nums, 1..) |num, j| {
                if (std.mem.startsWith(u8, line[i..], num)) {
                    if (first == null) {
                        first = @intCast(j);
                    } else {
                        last = @intCast(j);
                    }
                }
            }

            // check for digit num
            if (std.ascii.isDigit(c)) {
                if (first == null) {
                    first = c - '0';
                } else {
                    last = c - '0';
                }
            }
        }

        // some lines only have one number
        if (last == null) {
            last = first.?;
        }

        // multiply by 10 to put first in tens column
        const value = first.? * 10 + last.?;
        rollingSum += value;
    }

    return rollingSum;
}

pub fn main() !void {
    print("Part 1: {}\n", .{try partOne()});
    print("Part 2: {}\n", .{try partTwo()});
}

// Useful stdlib functions
const tokenizeAny = std.mem.tokenizeAny;
const tokenizeSeq = std.mem.tokenizeSequence;
const tokenizeSca = std.mem.tokenizeScalar;
const splitAny = std.mem.splitAny;
const splitSeq = std.mem.splitSequence;
const splitSca = std.mem.splitScalar;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.block;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
