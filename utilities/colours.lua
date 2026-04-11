SMODS.Gradient {
  key = "hungry",
  colours = {
    G.C.FILTER,
    G.C.GOLD,
    G.C.RED,
  },
  cycle = 5,
  interpolation = 'trig',
}

G.C.KH_PINK = HEX("f1bdac")

-- for stuff like {C:kh_hungry} or {C:kh_pink}
local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
  if not G.ARGS.LOC_COLOURS then
    loc_colour_ref()
  end
  G.ARGS.LOC_COLOURS["kh_pink"] = G.C.KH_PINK
  G.ARGS.LOC_COLOURS["kh_hungry"] = SMODS.Gradients.kh_hungry
  return loc_colour_ref(_c, _default)
end
