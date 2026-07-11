--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Valiant Shark Lancer  (ID: 23672629)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Beast-Warrior
-- Rank: 5
-- ATK 2500 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 5 monsters
-- You can target 1 monster your opponent controls; detach 1 material from an Xyz Monster you control,
-- and if you do, destroy that monster.
-- This is a Quick Effect if you control another WATER Xyz Monster.
-- If another WATER Xyz Monster(s) you control is destroyed by battle or card effect while you control
-- this monster: You can place 1 Spell from your Deck on top of your Deck.
-- You can only use each effect of "Valiant Shark Lancer" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ヴァリアント・シャーク・ランサー
function c23672629.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23672629,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,23672629)
	e1:SetCondition(c23672629.descon1)
	e1:SetTarget(c23672629.destg)
	e1:SetOperation(c23672629.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCondition(c23672629.descon2)
	c:RegisterEffect(e2)
	--deck top
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23672629,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,23672630)
	e3:SetCondition(c23672629.tpcon)
	e3:SetTarget(c23672629.tptg)
	e3:SetOperation(c23672629.tpop)
	c:RegisterEffect(e3)
end
function c23672629.descon1(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c23672629.desfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c23672629.descon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c23672629.desfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c23672629.desfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_XYZ)
end
function c23672629.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil)
		and Duel.CheckRemoveOverlayCard(tp,1,0,1,REASON_EFFECT) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c23672629.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.RemoveOverlayCard(tp,1,0,1,1,REASON_EFFECT) and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c23672629.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp)
		and bit.band(c:GetPreviousAttributeOnField(),ATTRIBUTE_WATER)~=0 and bit.band(c:GetPreviousTypeOnField(),TYPE_XYZ)~=0
		and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c23672629.tpcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23672629.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function c23672629.tptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_DECK,0,1,nil,TYPE_SPELL) end
end
function c23672629.tpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(23672629,2))
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,1,1,nil,TYPE_SPELL)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
