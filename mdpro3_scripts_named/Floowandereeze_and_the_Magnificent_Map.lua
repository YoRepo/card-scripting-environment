--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Floowandereeze and the Magnificent Map  (ID: 28126717)
-- Type: Spell / Field
-- Setcode: 0x16d
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase: You can reveal 1 Level 1 "Floowandereeze" monster in your hand and banish 1
-- "Floowandereeze" card with a different name from your Deck, then, immediately after this effect
-- resolves, Normal Summon the revealed monster.
-- If your opponent Normal Summons a monster: Immediately after this effect resolves, you can Normal
-- Summon 1 "Floowandereeze" monster.
-- You can only use each effect of "Floowandereeze and the Magnificent Map" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ふわんだりぃずと謎の地図
function c28126717.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Remove + Normal Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28126717,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1,28126717)
	e1:SetTarget(c28126717.rmtg)
	e1:SetOperation(c28126717.rmop)
	c:RegisterEffect(e1)
	--Normal Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(28126717,1))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,28126718)
	e2:SetCondition(c28126717.sumcon)
	e2:SetTarget(c28126717.sumtg)
	e2:SetOperation(c28126717.sumop)
	c:RegisterEffect(e2)
end
function c28126717.rmcfilter(c,tp)
	return c:IsLevel(1) and c:IsSetCard(0x16d) and c:IsSummonable(true,nil) and not c:IsPublic()
		and Duel.IsExistingMatchingCard(c28126717.rmfilter,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c28126717.rmfilter(c,code)
	return c:IsSetCard(0x16d) and not c:IsCode(code) and c:IsAbleToRemove()
end
function c28126717.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28126717.rmcfilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c28126717.rmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g1=Duel.SelectMatchingCard(tp,c28126717.rmcfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	if g1:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g2=Duel.SelectMatchingCard(tp,c28126717.rmfilter,tp,LOCATION_DECK,0,1,1,nil,g1:GetFirst():GetCode())
		if Duel.Remove(g2,POS_FACEUP,REASON_EFFECT)>0 then
			Duel.BreakEffect()
			Duel.Summon(tp,g1:GetFirst(),true,nil)
		end
	end
end
function c28126717.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c28126717.sumfilter(c)
	return c:IsSetCard(0x16d) and c:IsSummonable(true,nil)
end
function c28126717.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28126717.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c28126717.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c28126717.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
