--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Gouki Iron Claw  (ID: 71555408)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 2
-- ATK 1000 | DEF 0
-- Setcode: 0xfc
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the Damage Step, when your "Gouki" monster battles an opponent's monster (Quick Effect): You
-- can send this card from your hand to the GY; until the end of this turn, your monster gains 500 ATK,
-- and if it does, it is unaffected by your opponent's card effects.
-- If this card is sent from the field to the GY: You can add 1 "Gouki" card from your Deck to your
-- hand, except "Gouki Iron Claw".
-- You can only use each effect of "Gouki Iron Claw" once per turn.
--[[ __CARD_HEADER_END__ ]]

--剛鬼アイアン・クロー
function c71555408.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71555408,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCountLimit(1,71555408)
	e1:SetCondition(c71555408.atkcon)
	e1:SetCost(c71555408.atkcost)
	e1:SetOperation(c71555408.atkop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(71555408,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,71555409)
	e2:SetCondition(c71555408.thcon)
	e2:SetTarget(c71555408.thtg)
	e2:SetOperation(c71555408.thop)
	c:RegisterEffect(e2)
end
function c71555408.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsControler(tp) then a,d=d,a end
	e:SetLabelObject(a)
	return a and a:IsFaceup() and a:IsControler(tp) and a:IsSetCard(0xfc) and a:IsRelateToBattle()
		and d and d:IsControler(1-tp)
end
function c71555408.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c71555408.atkop(e,tp,eg,ep,ev,re,r,rp)
	local a=e:GetLabelObject()
	if not a or not a:IsRelateToBattle() then return end
	if a:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetValue(c71555408.efilter)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e2:SetOwnerPlayer(tp)
		a:RegisterEffect(e2)
	end
end
function c71555408.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c71555408.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c71555408.thfilter(c)
	return c:IsSetCard(0xfc) and not c:IsCode(71555408) and c:IsAbleToHand()
end
function c71555408.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71555408.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c71555408.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c71555408.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
