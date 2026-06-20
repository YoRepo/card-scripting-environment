--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 沉默剑士 LV7  (ID: 37267041)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Warrior
-- Level 7
-- ATK 2800 | DEF 1000
-- Setcode: 4260071
--
-- Effect Text:
-- 这张卡不能通常召唤。「沉默剑士 LV5」的效果才能特殊召唤。
-- ①：只要这张卡在怪兽区域存在，场上的魔法卡的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--サイレント・ソードマン LV7
function c37267041.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e2:SetTarget(c37267041.distg)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c37267041.disop)
	c:RegisterEffect(e3)
end
c37267041.lvup={74388798}
c37267041.lvdn={1995985,74388798}
function c37267041.distg(e,c)
	return c:IsType(TYPE_SPELL)
end
function c37267041.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if bit.band(tl,LOCATION_SZONE)~=0 and re:IsActiveType(TYPE_SPELL) then
		Duel.NegateEffect(ev)
	end
end
