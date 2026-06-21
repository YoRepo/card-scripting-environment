--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Hidden Infant  (ID: 211160)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level 3
-- ATK 1000 | DEF 2200
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- Must first either be Special Summoned by the effect of "Crimsonheart Revelation", or Special
-- Summoned (from your Extra Deck) by banishing 1 "Barren Lady Lacrimosaica" and 1 "Crimsonheart Rose
-- Key" from your GY. You can only use the (2) effect of "Crimsonheart Hidden Infant" once per turn.
-- (1) Cannot be destroyed by battle.
-- (2) When your opponent activates a card or effect (Quick Effect): You can Special Summon 1
-- "Lacrimosa, the Mother of Abominations" from your Extra Deck.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Hidden Infant
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000,211030,211170,211180)
	c:EnableReviveLimit()
	--cannot be Special Summoned by other means (Revelation summons it via nocheck)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.FALSE)
	c:RegisterEffect(e0)
	--SS proc: banish 1 "Barren Lady Lacrimosaica" + 1 "Crimsonheart Rose Key" from GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(1) cannot be destroyed by battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--(2) (Quick Effect) when opponent activates a card/effect: SS 1 Lacrimosa from Extra Deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id)
	e3:SetCondition(s.spcon2)
	e3:SetTarget(s.sptg2)
	e3:SetOperation(s.spop2)
	c:RegisterEffect(e3)
end
--SS proc (banish from GY)
function s.rmfilter1(c)
	return c:IsCode(211000) and c:IsAbleToRemoveAsCost()
end
function s.rmfilter2(c)
	return c:IsCode(211030) and c:IsAbleToRemoveAsCost()
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
		and Duel.IsExistingMatchingCard(s.rmfilter1,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(s.rmfilter2,tp,LOCATION_GRAVE,0,1,nil)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g1=Duel.GetMatchingGroup(s.rmfilter1,tp,LOCATION_GRAVE,0,nil)
	local g2=Duel.GetMatchingGroup(s.rmfilter2,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg2=g2:Select(tp,1,1,nil)
	sg1:Merge(sg2)
	sg1:KeepAlive()
	e:SetLabelObject(sg1)
	return true
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if g then
		Duel.Remove(g,POS_FACEUP,REASON_COST)
		g:DeleteGroup()
	end
end
--(2)
function s.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function s.spfilter2(c,e,tp)
	return c:IsCode(211170) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
