--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 神殿守卫者  (ID: 24221739)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 4
-- ATK 1100 | DEF 1900
--
-- Effect Text:
-- 当这张卡在场上以表侧表示存在时，对方不能在抽卡阶段以外进行抽卡。
--[[ __CARD_HEADER_END__ ]]

--神殿を守る者
function c24221739.initial_effect(c)
	--cannot draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_DRAW)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c24221739.con)
	c:RegisterEffect(e1)
end
function c24221739.con(e)
	return Duel.GetCurrentPhase()~=PHASE_DRAW
end
