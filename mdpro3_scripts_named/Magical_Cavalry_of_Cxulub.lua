--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 苏鲁伯的魔导骑兵  (ID: 23220863)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 4
-- Pendulum Scales: L3 / R3
-- ATK 1500 | DEF 1800
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- 【怪兽效果】
-- ①：这张卡只要在怪兽区域存在，不受灵摆怪兽以外的怪兽发动的效果影响。
--[[ __CARD_HEADER_END__ ]]

--シュルブの魔導騎兵
function c23220863.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c23220863.efilter)
	c:RegisterEffect(e1)
end
function c23220863.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:IsActivated() and not te:GetOwner():IsType(TYPE_PENDULUM)
end
