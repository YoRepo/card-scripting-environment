--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Phantom Dragon  (ID: 49879995)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 8
-- ATK 2300 | DEF 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent Special Summons a monster (except during the Damage Step): You can Special Summon
-- this card from your hand. 2 of your Monster Card Zones cannot be used.
--[[ __CARD_HEADER_END__ ]]

--ファントム・ドラゴン
function c49879995.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49879995,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c49879995.spcon)
	e1:SetTarget(c49879995.sptg)
	e1:SetOperation(c49879995.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_USE_EXTRA_MZONE)
	e2:SetValue(2)
	c:RegisterEffect(e2)
end
function c49879995.cfilter(c,tp)
	return c:IsSummonPlayer(1-tp)
end
function c49879995.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c49879995.cfilter,1,nil,tp)
end
function c49879995.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c49879995.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
