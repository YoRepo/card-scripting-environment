--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Achichi @Ignister  (ID: 15808381)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Cyberse
-- Level: 2
-- ATK 800 | DEF 800
-- Setcode: 0x135
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal or Special Summoned: You can add 1 Level 4 or lower "@Ignister" monster from
-- your Deck to your hand, except "Achichi @Ignister".
-- At the start of the Damage Step, when your Cyberse monster battles: You can banish this card from
-- your GY; destroy that monster you control.
-- You can only use each effect of "Achichi @Ignister" once per turn.
--[[ __CARD_HEADER_END__ ]]

--アチチ＠イグニスター
function c15808381.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15808381,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,15808381)
	e1:SetTarget(c15808381.thtg)
	e1:SetOperation(c15808381.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(15808381,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,15808382)
	e3:SetCondition(c15808381.descon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c15808381.destg)
	e3:SetOperation(c15808381.desop)
	c:RegisterEffect(e3)
end
function c15808381.thfilter(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x135) and c:IsType(TYPE_MONSTER) and not c:IsCode(15808381) and c:IsAbleToHand()
end
function c15808381.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c15808381.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c15808381.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c15808381.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c15808381.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsRace(RACE_CYBERSE)
end
function c15808381.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if chk==0 then return bc end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c15808381.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsControler(tp) then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
