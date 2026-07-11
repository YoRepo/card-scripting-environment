--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Varar, Vaalmonican Concord  (ID: 1340142)
-- Type: Monster / Effect / Link
-- Attribute: WATER
-- Race: Spellcaster
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 3000
-- Setcode: 0x1a3
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 monsters, including a "Vaalmonica" Link Monster
-- Unaffected by card effects, except "Vaalmonica" cards, while you have 6 or more Resonance Counters
-- on your field.
-- Gains 1 additional attack during each Battle Phase, for each Level 4 "Vaalmonica" monster you
-- control.
-- Once per turn, when your opponent would Special Summon a monster(s), if you have 3+ Resonance
-- Counters on your field (Quick Effect): You can negate the Special Summon, and if you do, destroy
-- that monster(s), then remove 3 Resonance Counters from your field.
--[[ __CARD_HEADER_END__ ]]

--ヴァルモニカの神奏－ヴァーラル
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddLinkProcedure(c,nil,2,2,s.lcheck)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.imcon)
	e1:SetValue(s.efilter)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(s.atkval)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_SPSUMMON)
	e3:SetCountLimit(1)
	e3:SetCondition(s.discon)
	e3:SetTarget(s.distg)
	e3:SetOperation(s.disop)
	c:RegisterEffect(e3)
end
function s.lfilter(c)
	return c:IsLinkType(TYPE_LINK) and c:IsLinkSetCard(0x1a3)
end
function s.lcheck(g)
	return g:IsExists(s.lfilter,1,nil)
end
function s.cfilter(c)
	return c:GetCounter(0x6a)>0
end
function s.iee(c)
	return c:GetCounter(0x6a)
end
function s.imcon(e)
	local sg=Duel.GetMatchingGroup(s.cfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,nil)
	local ct=sg:GetSum(s.iee)
	return ct>5
end
function s.efilter(e,te)
	return not te:GetOwner():IsSetCard(0x1a3)
end
function s.atkfilter(c)
	return c:IsLevel(4) and c:IsFaceup() and c:IsSetCard(0x1a3)
end
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(s.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and Duel.GetCurrentChain()==0
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x6a,3,REASON_EFFECT) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.NegateSummon(eg)
	if Duel.IsCanRemoveCounter(tp,1,0,0x6a,3,REASON_EFFECT) then
		Duel.BreakEffect()
		Duel.RemoveCounter(tp,1,0,0x6a,3,REASON_EFFECT)
	end
end
