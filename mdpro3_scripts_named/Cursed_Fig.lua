--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Cursed Fig  (ID: 18489208)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level: 1
-- ATK 200 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is destroyed by battle and sent to the Graveyard: Target 2 Set Spell/Trap Cards on
-- the field; while this card is in the Graveyard, those Set cards cannot be activated.
--[[ __CARD_HEADER_END__ ]]

--カースド・フィグ
function c18489208.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18489208,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c18489208.con)
	e1:SetTarget(c18489208.tg)
	e1:SetOperation(c18489208.op)
	c:RegisterEffect(e1)
end
function c18489208.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c18489208.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsFacedown() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,LOCATION_SZONE,LOCATION_SZONE,2,2,nil)
end
function c18489208.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_GRAVE) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	while tc do
		if c:IsRelateToEffect(e) and tc:IsFacedown() and tc:IsRelateToEffect(e) then
			c:SetCardTarget(tc)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_TRIGGER)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetCondition(c18489208.rcon)
			tc:RegisterEffect(e1,true)
		end
		tc=g:GetNext()
	end
end
function c18489208.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
