--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 堕天使 埃地·阿拉耶  (ID: 47664723)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 5
-- ATK 2300 | DEF 2000
-- Setcode: 239
--
-- Effect Text:
-- ①：从墓地特殊召唤的这张卡得到以下效果。
-- ●这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--堕天使エデ・アーラエ
function c47664723.initial_effect(c)
	--spsum success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c47664723.gete)
	c:RegisterEffect(e1)
end
function c47664723.gete(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsPreviousLocation(LOCATION_GRAVE) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
