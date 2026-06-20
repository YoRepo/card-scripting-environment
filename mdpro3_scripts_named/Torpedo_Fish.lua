--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 鱼雷鱼  (ID: 90337190)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 3
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- 当场上存在「海」时，这张卡不受魔法效果的影响。
--[[ __CARD_HEADER_END__ ]]

--魚雷魚
function c90337190.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c90337190.econ)
	e1:SetValue(c90337190.efilter)
	c:RegisterEffect(e1)
end
function c90337190.econ(e)
	return Duel.IsEnvironment(22702055)
end
function c90337190.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
