--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 丰穰之阿耳特弥斯  (ID: 32296881)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1600 | DEF 1700
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，每次自己或者对方把反击陷阱卡发动，自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--豊穣のアルテミス
function c32296881.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c32296881.drop)
	c:RegisterEffect(e1)
end
function c32296881.drop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_COUNTER) then return end
	Duel.Hint(HINT_CARD,0,32296881)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
