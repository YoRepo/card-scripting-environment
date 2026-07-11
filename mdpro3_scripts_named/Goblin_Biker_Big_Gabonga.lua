--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Goblin Biker Big Gabonga  (ID: 34001672)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Rank: 3
-- ATK 2100 | DEF 0
-- Setcode: 0x10ac
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 3 monsters
-- If this card is Xyz Summoned: You can add 1 "Goblin" monster from your Deck to your hand.
-- If material is detached from a monster(s) on the field (except during the Damage Step): You can
-- target 1 face-up monster on the field, except this card; attach it to this card as material.
-- During the End Phase: You can attach 1 "Goblin" monster from your Deck to this card as material.
-- You can only use each effect of "Goblin Biker Big Gabonga" once per turn.
--[[ __CARD_HEADER_END__ ]]

--百鬼羅刹 巨魁ガボンガ
function c34001672.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DETACH_EVENT)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34001672,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,34001672)
	e1:SetCondition(c34001672.thcon)
	e1:SetTarget(c34001672.thtg)
	e1:SetOperation(c34001672.thop)
	c:RegisterEffect(e1)
	--as material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34001672,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DETACH_MATERIAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,34001672+100)
	e2:SetCondition(c34001672.xmcon)
	e2:SetTarget(c34001672.xmtg)
	e2:SetOperation(c34001672.xmop)
	c:RegisterEffect(e2)
	--material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34001672,2))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,34001672+1)
	e3:SetTarget(c34001672.mttg)
	e3:SetOperation(c34001672.mtop)
	c:RegisterEffect(e3)
end
function c34001672.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c34001672.filter(c)
	return c:IsSetCard(0xac) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c34001672.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34001672.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c34001672.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c34001672.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c34001672.xmfilter(c)
	return c:IsFaceup() and c:IsCanOverlay()
end
function c34001672.xmcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsLocation,1,nil,LOCATION_MZONE)
end
function c34001672.xmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return (chkc:IsLocation(LOCATION_MZONE)) and (chkc~=c) and (c34001672.xmfilter(chkc)) end
	if chk==0 then return Duel.IsExistingTarget(c34001672.xmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	Duel.SelectTarget(tp,c34001672.xmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c)
end
function c34001672.xmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c34001672.mtfilter(c)
	return c:IsSetCard(0xac) and c:IsCanOverlay() and c:IsType(TYPE_MONSTER)
end
function c34001672.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c34001672.mtfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c34001672.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c34001672.mtfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
