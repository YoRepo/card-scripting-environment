--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 正义盟军 D.D.阻隔虫  (ID: 72845813)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1700 | DEF 1200
-- Setcode: 1
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，双方不能把光属性怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--A・O・J D.D.チェッカー
function c72845813.initial_effect(c)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT))
	c:RegisterEffect(e1)
end
