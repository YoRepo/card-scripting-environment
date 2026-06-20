--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 失乐之圣女  (ID: 68018709)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 100 | DEF 2000
--
-- Effect Text:
-- 这个卡名的效果在决斗中只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己在对方回合可以把1张速攻魔法卡从手卡发动。
--[[ __CARD_HEADER_END__ ]]

--失楽の聖女
function c68018709.initial_effect(c)
	--act qp in hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68018709,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCountLimit(1,68018709+EFFECT_COUNT_CODE_DUEL)
	c:RegisterEffect(e1)
end
