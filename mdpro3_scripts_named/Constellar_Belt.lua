--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 神星领域  (ID: 86825483)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 83
--
-- Effect Text:
-- 只要这张卡在场上存在，光属性怪兽的效果的发动不会被无效化。
--[[ __CARD_HEADER_END__ ]]

--神星なる領域
function c86825483.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--inactivatable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_INACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(c86825483.efilter)
	c:RegisterEffect(e2)
end
function c86825483.efilter(e,ct)
	local te=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT)
	local tc=te:GetHandler()
	return te:IsActiveType(TYPE_MONSTER) and tc:IsAttribute(ATTRIBUTE_LIGHT)
end
