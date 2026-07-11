--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Bujin Arasuda  (ID: 23979249)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1600 | DEF 1900
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Bujin" monster in your Graveyard or face-up on your side of the field is banished (except
-- during the Damage Step): You can Special Summon this card from your hand in face-up Defense
-- Position.
-- Once per turn, during the End Phase, if a "Bujin" card was added from your Deck to your hand this
-- turn, except by drawing it, while you controlled this face-up card: You can draw 1 card, then
-- discard 1 card.
-- You can only control 1 "Bujin Arasuda".
--[[ __CARD_HEADER_END__ ]]

--武神－アラスダ
function c23979249.initial_effect(c)
	c:SetUniqueOnField(1,0,23979249)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23979249,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c23979249.spcon)
	e1:SetTarget(c23979249.sptg)
	e1:SetOperation(c23979249.spop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c23979249.regcon)
	e2:SetOperation(c23979249.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23979249,1))
	e3:SetCategory(CATEGORY_DRAW+CATEGORY_HANDES_SELF)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c23979249.drcon)
	e3:SetTarget(c23979249.drtg)
	e3:SetOperation(c23979249.drop)
	c:RegisterEffect(e3)
end
function c23979249.cfilter(c,tp)
	return c:IsSetCard(0x88) and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_MZONE+LOCATION_GRAVE)
end
function c23979249.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23979249.cfilter,1,nil,tp)
end
function c23979249.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c23979249.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
function c23979249.regfilter(c,tp)
	return c:IsSetCard(0x88) and c:IsControler(tp) and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_DECK) and not c:IsReason(REASON_DRAW)
end
function c23979249.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23979249.regfilter,1,nil,tp)
end
function c23979249.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(23979249,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c23979249.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(23979249)>0
end
function c23979249.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_HANDES_SELF,nil,0,tp,1)
end
function c23979249.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)~=0 then
		Duel.ShuffleHand(tp)
		Duel.BreakEffect()
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end
