--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Crusadia Power  (ID: 96434581)
-- Type: Spell / Quick-Play
-- Setcode: 0x116
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 "Crusadia" monster you control; that "Crusadia" monster is unaffected by card effects this
-- turn, except its own.
-- You can only activate 1 "Crusadia Power" per turn.
--[[ __CARD_HEADER_END__ ]]

--オーバード・パラディオン
function c96434581.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,96434581+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c96434581.target)
	e1:SetOperation(c96434581.activate)
	c:RegisterEffect(e1)
end
function c96434581.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x116)
end
function c96434581.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c96434581.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c96434581.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c96434581.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c96434581.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c96434581.efilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c96434581.efilter(e,re)
	return e:GetHandler()~=re:GetOwner()
end
