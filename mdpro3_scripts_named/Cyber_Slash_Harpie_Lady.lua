--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Cyber Slash Harpie Lady  (ID: 63261835)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 8
-- ATK 2600 | DEF 1400
-- Setcode: 0x64
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner monsters
-- For this card's Synchro Summon, you can treat 1 "Harpie" monster you control as a Tuner.
-- This card's name becomes "Harpie Lady" while on the field or in the GY.
-- When a Spell/Trap Card or effect is activated (except during the Damage Step) (Quick Effect): You
-- can target 1 monster your opponent controls or 1 "Harpie" monster you control; return it to the
-- hand.
-- You can only use this effect of "Cyber Slash Harpie Lady" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・レディ・SC
function c63261835.initial_effect(c)
	--synchro summon
	c:EnableReviveLimit()
	aux.AddSynchroMixProcedure(c,c63261835.matfilter1,nil,nil,aux.NonTuner(nil),1,99)
	--change name
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63261835,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,63261835)
	e2:SetCondition(c63261835.thcon)
	e2:SetTarget(c63261835.thtg)
	e2:SetOperation(c63261835.thop)
	c:RegisterEffect(e2)
end
function c63261835.matfilter1(c,syncard)
	return c:IsTuner(syncard) or c:IsSetCard(0x64)
end
function c63261835.thcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c63261835.thfilter(c,tp)
	return (c:IsControler(1-tp) or (c:IsFaceup() and c:IsSetCard(0x64))) and c:IsAbleToHand()
end
function c63261835.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c63261835.thfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c63261835.thfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c63261835.thfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c63261835.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
