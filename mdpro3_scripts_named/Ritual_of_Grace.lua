--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Ritual of Grace  (ID: 60234913)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Divine Grace - Northwemko".
-- You must also Tribute monsters whose total Levels equal 7 or more from the field or your hand.
-- During your Main Phase, you can remove from play this card from your Graveyard to make 1 face-up
-- Ritual Monster you control become un-targetable by effects this turn.
--[[ __CARD_HEADER_END__ ]]

--救世の儀式
function c60234913.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,61757117)
	--untargetable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60234913,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c60234913.uttg)
	e1:SetOperation(c60234913.utop)
	c:RegisterEffect(e1)
end
function c60234913.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL)
end
function c60234913.uttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c60234913.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60234913.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c60234913.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c60234913.utop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
