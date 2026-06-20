--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 骑士道精神  (ID: 60519422)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的怪兽和攻击力相同的怪兽战斗时不会被破坏。
--[[ __CARD_HEADER_END__ ]]

--騎士道精神
function c60519422.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c60519422.indtg)
	e2:SetValue(c60519422.indval)
	c:RegisterEffect(e2)
end
function c60519422.indtg(e,c)
	e:SetLabel(c:GetAttack())
	return true
end
function c60519422.indval(e,c)
	return c:IsAttack(e:GetLabel())
end
