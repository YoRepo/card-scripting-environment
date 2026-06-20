--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 仪式的供物  (ID: 34334692)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 300 | DEF 300
--
-- Effect Text:
-- 暗属性的仪式怪兽特殊召唤的场合，可以让这1张卡作为仪式召唤的祭品使用。
--[[ __CARD_HEADER_END__ ]]

--儀式の供物
function c34334692.initial_effect(c)
	--ritual level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_RITUAL_LEVEL)
	e1:SetValue(c34334692.rlevel)
	c:RegisterEffect(e1)
end
function c34334692.rlevel(e,c)
	local lv=aux.GetCappedLevel(e:GetHandler())
	if c:IsAttribute(ATTRIBUTE_DARK) then
		local clv=c:GetLevel()
		return (lv<<16)+clv
	else return lv end
end
