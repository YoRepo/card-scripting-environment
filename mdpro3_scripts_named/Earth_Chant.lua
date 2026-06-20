--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 大地赞颂  (ID: 59820352)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 可以使地属性的仪式怪兽降临。特殊召唤时，必须以场上和/或手卡中合计等级与此地属性仪式怪兽等级相同的怪兽作为祭品。
--[[ __CARD_HEADER_END__ ]]

--大地讃頌
function c59820352.initial_effect(c)
	aux.AddRitualProcEqual2(c,c59820352.ritual_filter)
end
function c59820352.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_EARTH)
end
