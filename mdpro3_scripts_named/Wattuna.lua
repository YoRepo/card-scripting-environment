--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Wattuna  (ID: 10113611)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 4
-- ATK 800 | DEF 700
-- Setcode: 0xe
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can attack directly.
-- You can only use each of the following effects of "Wattuna" once per turn.
-- At the end of the Damage Step, if your monster inflicts battle damage to your opponent: You can
-- Special Summon this card from your hand.
-- When this card inflicts battle damage to your opponent by a direct attack: You can Tribute this card
-- on the field and 1 or more non-Tuner monsters from your hand and/or face-up field, and Special
-- Summon 1 "Watt" Synchro Monster from your Extra Deck whose Level equals the total Levels of those
-- Tributed monsters.
--[[ __CARD_HEADER_END__ ]]

--エレキハダマグロ
local s,id,o=GetID()
function s.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	if not s.global_check then
		s.global_check=true
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_BATTLE_DAMAGE)
		e3:SetCondition(s.regcon)
		e3:SetOperation(s.regop)
		Duel.RegisterEffect(e3,0)
	end
	--s summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_RELEASE+CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCountLimit(1,id+o)
	e4:SetCondition(s.sscon)
	e4:SetTarget(s.sstg)
	e4:SetOperation(s.ssop)
	c:RegisterEffect(e4)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,id)>0
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) end
end
function s.regcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=rp
end
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(rp,id,RESET_PHASE+PHASE_DAMAGE,0,1)
end
function s.sscon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and Duel.GetAttackTarget()==nil
end
function s.mfilter(c)
	return not c:IsType(TYPE_TUNER) and c:IsFaceupEx() and c:GetLevel()>0
end
function s.spfilter(c,e,tp,g)
	return c:IsSetCard(0xe) and c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and g:CheckSubGroup(s.gcheck,1,#g,tp,e:GetHandler(),c)
end
function s.gcheck(g,tp,ec,sc)
	return Duel.GetLocationCountFromEx(tp,tp,g+ec,sc)>0 and g:GetSum(Card.GetLevel)+ec:GetLevel()==sc:GetLevel()
end
function s.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetReleaseGroup(tp,true,REASON_EFFECT):Filter(s.mfilter,c)
	if chk==0 then return c:IsReleasableByEffect() and c:GetLevel()>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,g) end
	Duel.SetOperationInfo(0,CATEGORY_RELEASE,g,2,0,0)
end
function s.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetReleaseGroup(tp,true,REASON_EFFECT):Filter(s.mfilter,c)
	if not (c:IsRelateToEffect(e) and c:IsReleasableByEffect()) or #g==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,g):GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local sg=g:SelectSubGroup(tp,s.gcheck,false,1,#g,tp,c,tc)+c
		if Duel.Release(sg,REASON_EFFECT)>0 then Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) end
	end
end
