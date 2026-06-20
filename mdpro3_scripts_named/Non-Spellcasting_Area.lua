--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 绝对魔法禁止区域  (ID: 20065549)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上所有表侧表示的效果怪兽以外的怪兽不受魔法效果的影响。
--[[ __CARD_HEADER_END__ ]]

--絶対魔法禁止区域
function c20065549.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c20065549.etarget)
	e2:SetValue(c20065549.efilter)
	c:RegisterEffect(e2)
end
function c20065549.etarget(e,c)
	return not c:IsType(TYPE_EFFECT)
end
function c20065549.efilter(e,re)
	return re:IsActiveType(TYPE_SPELL)
end
