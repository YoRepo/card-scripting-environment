--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Counselor Lily  (ID: 5519829)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Fairy
-- Level: 3
-- ATK 400 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is sent to the Graveyard for a Synchro Summon, you can pay 500 Life Points to have
-- that Synchro Monster gain 1000 ATK until the End Phase.
--[[ __CARD_HEADER_END__ ]]

--メンタル・カウンセラー リリー
function c5519829.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5519829,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c5519829.con)
	e1:SetCost(c5519829.cost)
	e1:SetTarget(c5519829.tg)
	e1:SetOperation(c5519829.op)
	c:RegisterEffect(e1)
	aux.CreateMaterialReasonCardRelation(c,e1)
end
function c5519829.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c5519829.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c5519829.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local rc=e:GetHandler():GetReasonCard()
	if chk==0 then return rc:IsRelateToEffect(e) and rc:IsFaceup() end
	Duel.SetTargetCard(rc)
end
function c5519829.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sync=Duel.GetFirstTarget()
	if not sync:IsRelateToChain() or sync:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	sync:RegisterEffect(e1)
end
